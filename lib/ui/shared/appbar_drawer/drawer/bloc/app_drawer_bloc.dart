import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/auth_service.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/provider/user_state.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/space_service.dart';
import 'app_drawer_event.dart';
import 'app_drawer_state.dart';

@Injectable()
class DrawerBloc extends Bloc<DrawerEvents, DrawerState> {
  final SpaceService _spaceService;
  final AccountService _accountService;
  final UserStateNotifier _userManager;
  final AuthService _authService;
  final EmployeeService _employeeService;

  DrawerBloc(this._spaceService, this._userManager, this._accountService,
      this._employeeService, this._authService)
      : super(const DrawerState()) {
    on<FetchSpacesEvent>(_fetchSpaces);
    on<ChangeSpaceEvent>(_changeSpace);
    on<SignOutEvent>(_signOut);
  }

  Future<void> _fetchSpaces(
      FetchSpacesEvent event, Emitter<DrawerState> emit) async {
    emit(state.copyWith(
        fetchSpacesStatus: Status.loading, changeSpaceStatus: Status.initial));
    try {
      final List<String> spaceIds =
          await _accountService.fetchSpaceIds(uid: _userManager.userUID!);
      final spaces = await Future.wait(spaceIds.map((spaceId) async {
        return await _spaceService.getSpace(spaceId);
      })).then((value) => value.whereNotNull().toList());
      emit(state.copyWith(fetchSpacesStatus: Status.success, spaces: spaces));
    } on Exception {
      emit(state.copyWith(
          fetchSpacesStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _changeSpace(
      ChangeSpaceEvent event, Emitter<DrawerState> emit) async {
    emit(state.copyWith(changeSpaceStatus: Status.loading));
    try {
      final spaceUser = await _employeeService.getEmployeeBySpaceId(
          spaceId: event.space.id, userId: _userManager.userUID!);
      if (spaceUser != null) {
        await _userManager.setEmployeeWithSpace(
            space: event.space, spaceUser: spaceUser);
        emit(state.copyWith(changeSpaceStatus: Status.success));
      } else {
        emit(state.copyWith(
            changeSpaceStatus: Status.error, error: firestoreFetchDataError));
      }
    } on Exception {
      emit(state.copyWith(
          changeSpaceStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _signOut(SignOutEvent event, Emitter<DrawerState> emit) async {
    emit(state.copyWith(signOutStatus: Status.loading));
    bool isLogOut = await _authService.signOutWithGoogle();
    if (isLogOut) {
      await _userManager.removeAll();
      emit(state.copyWith(signOutStatus: Status.success));
    } else {
      emit(state.copyWith(error: signOutError, signOutStatus: Status.error));
    }
  }
}
