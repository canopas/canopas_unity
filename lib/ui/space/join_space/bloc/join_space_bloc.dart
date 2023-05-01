import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_event.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_state.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/space/space.dart';
import '../../../../data/services/employee_service.dart';
import '../../../../data/services/invitation_services.dart';
import '../../../../data/services/space_service.dart';

@Injectable()
class JoinSpaceBloc extends Bloc<JoinSpaceEvents, JoinSpaceState> {
  final UserManager _userManager;
  final EmployeeService _employeeService;
  final SpaceService _spaceService;
  final InvitationService _invitationService;

  JoinSpaceBloc(this._invitationService, this._spaceService, this._userManager,
      this._employeeService)
      : super(const JoinSpaceState()) {
    on<JoinSpaceInitialFetchEvent>(_init);
    on<SelectSpaceEvent>(_selectSpace);
  }

  String get userEmail => _userManager.userEmail ?? "unknown";

  Future<List<Space>> getRequestedSpaces() async {
    final requests = await _invitationService
        .fetchSpacesForUserEmail(_userManager.userEmail!);

    return await Future.wait(requests.map((invitation) async {
      return await _spaceService.getSpace(invitation.spaceId);
    })).then((value) => value.whereNotNull().toList());
  }

  void _init(
      JoinSpaceInitialFetchEvent event, Emitter<JoinSpaceState> emit) async {
    emit(state.copyWith(fetchSpaceStatus: Status.loading));
    try {
      final requests = await getRequestedSpaces();
      final ownSpaces =
          await _spaceService.getSpacesOfUser(_userManager.userUID!);
      emit(state.copyWith(
          fetchSpaceStatus: Status.success,
          ownSpaces: ownSpaces,
          requestedSpaces: requests));
    } on Exception {
      emit(state.copyWith(
          fetchSpaceStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _selectSpace(SelectSpaceEvent event, Emitter<JoinSpaceState> emit) async {
    emit(state.copyWith(selectSpaceStatus: Status.loading));
    try {
      final employee = await _employeeService.getEmployeeBySpaceId(
          spaceId: event.space.id, userId: _userManager.userUID!);
      if (employee != null) {
        await _userManager.setSpace(space: event.space, spaceUser: employee);
        emit(state.copyWith(selectSpaceStatus: Status.success));
      } else {
        emit(state.copyWith(
            selectSpaceStatus: Status.error, error: firestoreFetchDataError));
      }
    } on Exception {
      emit(state.copyWith(
          selectSpaceStatus: Status.error, error: firestoreFetchDataError));
    }
  }
}
