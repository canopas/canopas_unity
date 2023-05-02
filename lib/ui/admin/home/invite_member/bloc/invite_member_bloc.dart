import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';

import '../../../../../data/provider/user_data.dart';

import '../../../../../data/services/invitation_services.dart';
import 'invite_member_event.dart';
import 'invite_member_state.dart';

@Injectable()
class InviteMemberBloc extends Bloc<InvitationEvent, InviteMemberState> {
  final InvitationService _invitationService;
  final UserManager _userManager;

  InviteMemberBloc(this._invitationService, this._userManager)
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
    if (validEmail(state.email)) {
      emit(state.copyWith(status: Status.loading));
      try {
        await _invitationService.addInvitation(
            senderId: _userManager.userUID!,
            spaceId: _userManager.currentSpaceId!,
            receiverEmail: state.email!);
        emit(state.copyWith(status: Status.success));
      } on Exception catch (_) {
        emit(state.copyWith(
            status: Status.error, error: firestoreFetchDataError));
      }
    } else {
      emit(state.copyWith(
          error: provideRequiredInformation, status: Status.error));
    }
  }

  bool validEmail(String? email) =>
      email != null && RegExp(r'\S+@\S+\.\S+').hasMatch(email);
}
