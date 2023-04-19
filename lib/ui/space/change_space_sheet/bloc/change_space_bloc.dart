import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import '../../../../data/provider/user_data.dart';
import '../../../../data/services/employee_service.dart';
import '../../../../data/services/space_service.dart';
import 'change_space_events.dart';
import 'change_space_state.dart';

@Injectable()
class ChangeSpaceBloc extends Bloc<ChangeSpaceEvents, ChangeSpaceState> {
  final UserManager _userManager;
  final SpaceService _spaceService;
  final EmployeeService _employeeService;

  ChangeSpaceBloc(this._userManager, this._spaceService, this._employeeService)
      : super(const ChangeSpaceState()) {
    on<ChangeSpaceInitialLoadEvent>(_init);
    on<SelectSpaceEvent>(_changeSpace);
  }

  Future<void> _init(
      ChangeSpaceInitialLoadEvent event, Emitter<ChangeSpaceState> emit) async {
    emit(state.copyWith(fetchSpaceStatus: Status.loading));
    try {
      final spaces = await _spaceService.getSpacesOfUser(_userManager.userUID!);
      emit(state.copyWith(fetchSpaceStatus: Status.success, spaces: spaces));
    } on Exception {
      emit(state.copyWith(
          fetchSpaceStatus: Status.failure, error: firestoreFetchDataError));
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
            changeSpaceStatus: Status.failure, error: firestoreFetchDataError));
      }
    } on Exception {
      emit(state.copyWith(
          changeSpaceStatus: Status.failure, error: firestoreFetchDataError));
    }
  }
}
