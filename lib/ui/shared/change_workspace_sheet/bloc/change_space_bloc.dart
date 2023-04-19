import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import '../../../../data/provider/user_data.dart';
import '../../../../data/services/employee_service.dart';
import '../../../../data/services/space_service.dart';
import 'change_space_events.dart';
import 'change_space_state.dart';

@Injectable()
class ChangeSpaceBloc extends Bloc<ChangeSpaceEvents, ChangeSpaceStates> {
  final UserManager _userManager;
  final SpaceService _spaceService;
  final EmployeeService _employeeService;

  ChangeSpaceBloc(this._userManager, this._spaceService, this._employeeService)
      : super(ChangeSpaceInitialState()) {
    on<ChangeSpaceInitialLoadEvent>(_init);
    on<SelectSpaceEvent>(_changeSpace);
  }

  Future<void> _init(ChangeSpaceInitialLoadEvent event,
      Emitter<ChangeSpaceStates> emit) async {
    try {
      emit(ChangeSpaceLoadingState());
      final spaces = await _spaceService.getSpacesOfUser(_userManager.userUID!);
      emit(ChangeSpaceSuccessState(spaces));
    } on Exception {
      emit(ChangeSpaceFailureState(firestoreFetchDataError));
    }
  }

  Future<void> _changeSpace(
      SelectSpaceEvent event, Emitter<ChangeSpaceStates> emit) async {
    final spaceUser = await _employeeService.getEmployeeBySpaceId(
        spaceId: event.space.id, userId: _userManager.userUID!);
    if (spaceUser != null) {
      await _userManager.setSpace(space: event.space, spaceUser: spaceUser);
    }
  }
}
