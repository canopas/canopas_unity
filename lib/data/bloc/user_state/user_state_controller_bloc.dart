import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/bloc/user_state/space_change_notifier.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_event.dart';
import 'package:projectunity/data/bloc/user_state/user_controller_state.dart';
import 'package:projectunity/data/model/space/space.dart';
import '../../repo/employee_repo.dart';
import '../../model/employee/employee.dart';
import '../../provider/user_state.dart';
import '../../services/space_service.dart';

@Injectable()
class UserStateControllerBloc
    extends Bloc<UserStateControllerEvent, UserControllerStatus> {
  final EmployeeRepo _employeeRepo;
  final UserStateNotifier _userStateNotifier;
  final SpaceService _spaceService;
  final SpaceChangeNotifier _spaceChangeNotifier;
  StreamSubscription? _subscription;

  UserStateControllerBloc(
      this._employeeRepo, this._userStateNotifier, this._spaceService, this._spaceChangeNotifier)
      : super(const UserInitialStatus()) {
    on<CheckUserStatus>(_updateEmployee);
    on<ClearDataForDisableUser>(_clearData);
    on<UpdateUserData>(_updateData);
    on<ShowUserStatusFetchError>(_showError);

    log("Init user status", name: "User Status");
    _spaceChangeNotifier.addListener(() async {
      if(_subscription != null){
        await _subscription?.cancel();
        log("Stream canceled", name: "User Status");
      }
      if (_userStateNotifier.currentSpaceId != null) {
        add(CheckUserStatus());
      }
    });
    if (_userStateNotifier.currentSpaceId != null) {
      _spaceChangeNotifier.setSpaceId(spaceId: _userStateNotifier.currentSpaceId!);
    }
  }

  Future<void> _updateEmployee(
      CheckUserStatus event, Emitter<UserControllerStatus> emit) async {
    try {
      log("Function called", name: "User Status");
      final Space? space =
          await _spaceService.getSpace(_userStateNotifier.currentSpaceId!);
      log("space fetched", name: "User Status");
      _subscription =
          _employeeRepo.memberDetails(_userStateNotifier.userUID!).listen(
        (Employee? employee) async {
          log("Employee fetched", name: "User Status");
          add(UpdateUserData(employee: employee, space: space));
        },
        onError: (error, _) {
          add(ShowUserStatusFetchError());
        },
      );
    } on Exception {
      add(ShowUserStatusFetchError());
    }
  }

  Future<void> _updateData(
      UpdateUserData event, Emitter<UserControllerStatus> emit) async {
    if (event.employee != null && event.space != null && event.employee?.status == EmployeeStatus.active) {
      if (event.employee != _userStateNotifier.employee) {
        await _userStateNotifier.setEmployee(member: event.employee!);
        log("Employee updated", name: "User Status");
      }
      if (event.space != _userStateNotifier.currentSpace) {
        await _userStateNotifier.setSpace(space: event.space!);
        log("Space  updated", name: "User Status");
      }
      emit(const UserUpdatedStatus());
    } else {
      log("Revoked access", name: "User Status");
      emit(const UserAccessRevokedStatus());
    }
  }

  Future<void> _showError(ShowUserStatusFetchError event,
      Emitter<UserControllerStatus> emit) async {
    log("Error occurs", name: "User Status");
    emit(const UserErrorStatus());
  }

  Future<void> _clearData(
      ClearDataForDisableUser event, Emitter<UserControllerStatus> emit) async {
    await _userStateNotifier.removeEmployeeWithSpace();
    log("All data cleared", name: "User Status");
  }

  @override
  Future<void> close() async {
    _spaceChangeNotifier.removeSpaceId();
    _spaceChangeNotifier.removeListener(() { });
    await _subscription?.cancel();
    return super.close();
  }
}
