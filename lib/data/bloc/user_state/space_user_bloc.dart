import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/Repo/leave_repo.dart';
import 'package:projectunity/data/bloc/user_state/space_user_event.dart';
import 'package:projectunity/data/bloc/user_state/space_user_state.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:rxdart/rxdart.dart';
import '../../model/employee/employee.dart';
import '../../provider/space_manager.dart';
import '../../provider/user_state.dart';
import '../../services/space_service.dart';

@Injectable()
class SpaceUserBloc extends Bloc<SpaceUserEvent, SpaceUserState> {
  final UserStateNotifier _userStateNotifier;
  final SpaceService _spaceService;
  final EmployeeRepo _employeeRepo;
  final LeaveRepo _leaveRepo;
  final SpaceManager _spaceManager;
  StreamSubscription<Employee?>? _streamSubscription;
  final BehaviorSubject<Employee?> _userController =
      BehaviorSubject<Employee?>();

  SpaceUserBloc(this._employeeRepo, this._leaveRepo, this._userStateNotifier,
      this._spaceService, this._spaceManager)
      : super(SpaceUserInitialState()) {
    on<CheckSpaceEvent>(_checkUserStatus);
    on<CheckUserEvent>(_updateUserData);
    on<DeactivateUserEvent>(_deactivateUser);
    if (_userStateNotifier.state == UserState.spaceJoined) {
      add(CheckSpaceEvent());
    }
    _spaceManager.addListener(() {
      add(CheckSpaceEvent());
    });
  }

  Future<void> _checkUserStatus(
      CheckSpaceEvent status, Emitter<SpaceUserState> emit) async {
    if (_spaceManager.currentSpaceId == null) {
      if (_userStateNotifier.employee != null ||
          _userStateNotifier.currentSpace != null) {
        add(DeactivateUserEvent());
      }
    } else {
      final Space? space =
          await _spaceService.getSpace(_spaceManager.currentSpaceId!);
      if (space == null) {
        return;
      }
      _userStateNotifier.updateSpace(space);
      if (_streamSubscription != null) {
        _streamSubscription!.cancel();
      }
      try {
        await _resetStreamSubscription();
        _streamSubscription = _employeeRepo
            .getCurrentUser(
                spaceID: _userStateNotifier.currentSpaceId!,
                uid: _userStateNotifier.userUID!)
            .listen((event) {
          _userController.add(event);
          add(CheckUserEvent(employee: event));
        }, onError: (error, stackTrace) {
          emit(SpaceUserErrorState(error: firestoreFetchDataError));
          FirebaseCrashlytics.instance.recordError(error, stackTrace,
              reason: 'ERROR WHILE LISTENING THE CURRENT USER STRAEM');
        });
      } on Exception catch (error, stacktrace) {
        emit(SpaceUserErrorState(error: firestoreFetchDataError));
        FirebaseCrashlytics.instance.recordError(error, stacktrace,
            reason:
                'EXCEPTION == GET CURRENT USER INFO WHEN THE USER STATUS IS ${_userStateNotifier.state}');
      }
    }
  }

  Future<void> _updateUserData(
      CheckUserEvent event, Emitter<SpaceUserState> emit) async {
    if (event.employee == null) {
      emit(SpaceUserErrorState(error: firestoreFetchDataError));
    } else {
      if (event.employee!.status == EmployeeStatus.inactive) {
        emit(SpaceUserRevokeAccessState());
      } else {
        _userStateNotifier.updateCurrentUser(event.employee!);
      }
    }
  }

  Future<void> _deactivateUser(
      DeactivateUserEvent event, Emitter<SpaceUserState> emit) async {
    await _userStateNotifier.removeEmployeeWithSpace();
    await _spaceManager.removeCurrentSpaceID();
    await _cancelStreamSubscription();
  }

  Future<void> _cancelStreamSubscription() async {
    await _leaveRepo.cancel();
    await _employeeRepo.cancel();
  }

  Future<void> _resetStreamSubscription() async {
    await _leaveRepo.reset();
    await _employeeRepo.reset();
  }
}
