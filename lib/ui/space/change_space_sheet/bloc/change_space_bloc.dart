import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/provider/user_data.dart';
import '../../../../data/services/account_service.dart';
import '../../../../data/services/employee_service.dart';
import '../../../../data/services/space_service.dart';
import 'change_space_events.dart';
import 'change_space_state.dart';

@Injectable()
class ChangeSpaceBloc extends Bloc<ChangeSpaceEvents, ChangeSpaceState> {
  final UserManager _userManager;
  final SpaceService _spaceService;
  final EmployeeService _employeeService;
  final AccountService _accountService;

  ChangeSpaceBloc(this._userManager, this._spaceService, this._employeeService,
      this._accountService)
      : super(const ChangeSpaceState()) {
    on<ChangeSpaceInitialLoadEvent>(_init);
    on<SelectSpaceEvent>(_changeSpace);
  }

  Future<void> _init(
      ChangeSpaceInitialLoadEvent event, Emitter<ChangeSpaceState> emit) async {
    emit(state.copyWith(fetchSpaceStatus: Status.loading));
    try {
      final List<String> spaceIds =
          await _accountService.fetchSpaceIds(uid: _userManager.userUID!);
      if (spaceIds.contains(_userManager.currentSpaceId)) {
        spaceIds.remove(_userManager.currentSpaceId);
      }
      final spaces = await Future.wait(spaceIds.map((spaceId) async {
        return await _spaceService.getSpace(spaceId);
      })).then((value) => value.whereNotNull().toList());

      emit(state.copyWith(fetchSpaceStatus: Status.success, spaces: spaces));
    } on Exception {
      emit(state.copyWith(
          fetchSpaceStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _changeSpace(
      SelectSpaceEvent event, Emitter<ChangeSpaceState> emit) async {
    emit(state.copyWith(changeSpaceStatus: Status.loading));
    try {
      final spaceUser = await _employeeService.getEmployeeBySpaceId(
          spaceId: event.space.id, userId: _userManager.userUID!);
      if (spaceUser != null) {
        await _userManager.setSpace(space: event.space, spaceUser: spaceUser);
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
}
