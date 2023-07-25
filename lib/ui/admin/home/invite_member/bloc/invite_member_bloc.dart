import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/services/employee_service.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/provider/user_status_notifier.dart';
import '../../../../../data/services/invitation_services.dart';
import 'invite_member_event.dart';
import 'invite_member_state.dart';

@Injectable()
class InviteMemberBloc extends Bloc<InvitationEvent, InviteMemberState> {
  final InvitationService _invitationService;
  final EmployeeService _employeeService;
  final UserStatusNotifier _userManager;

  InviteMemberBloc(
      this._invitationService, this._userManager, this._employeeService)
      : super(const InviteMemberState()) {
    on<AddEmailEvent>(_enterEmailEvent);
    on<InviteMemberEvent>(_inviteMember);
  }

  Future<void> _enterEmailEvent(
      AddEmailEvent event, Emitter<InviteMemberState> emit) async {
    if (validEmail(event.query)) {
      emit(state.copyWith(email: event.query, emailError: false));
    } else {
      emit(state.copyWith(email: event.query, emailError: true));
    }
  }

  Future<void> _inviteMember(
      InviteMemberEvent event, Emitter<InviteMemberState> emit) async {
    emit(state.copyWith(status: Status.loading));
    if (validEmail(state.email)) {
      try {
        if (await _employeeService.hasUser(state.email) ||
            await _invitationService.checkMemberInvitationAlreadyExist(
                spaceId: _userManager.currentSpaceId!, email: state.email)) {
          emit(state.copyWith(error: userAlreadyInvited, status: Status.error));
        } else {
          await _invitationService.addInvitation(
              senderId: _userManager.userUID!,
              spaceId: _userManager.currentSpaceId!,
              receiverEmail: state.email);
          emit(state.copyWith(status: Status.success));
        }
      } on Exception {
        emit(state.copyWith(
            status: Status.error, error: firestoreFetchDataError));
      }
    } else {
      emit(state.copyWith(
          error: provideRequiredInformation, status: Status.error));
    }
  }

  bool validEmail(String email) => RegExp(r'\S+@\S+\.\S+').hasMatch(email);
}
