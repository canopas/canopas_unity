import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/services/employee_service.dart';
import 'member_list_event.dart';
import 'member_list_state.dart';

@Injectable()
class AdminMembersBloc extends Bloc<AdminMembersEvents, AdminMembersState> {
  final EmployeeService _employeeService;
  final UserStateNotifier _userStateNotifier;
  final InvitationService _invitationService;
  StreamSubscription? _membersDBSubscription;

  AdminMembersBloc(
      this._employeeService, this._invitationService, this._userStateNotifier)
      : super(const AdminMembersState()) {
    on<FetchInvitationEvent>(_fetchInvitation);
    on<ShowUpdatedMemberEvent>(_updateMembersList);
    on<ShowErrorEvent>(_showError);
    on<ShowLoadingEvent>(_showMembersLoading);

    _membersDBSubscription =
        _employeeService.memberDBSnapshot().listen((members) {
      add(ShowUpdatedMemberEvent(members));
    }, onError: (error, _) {
      add(const ShowErrorEvent(firestoreFetchDataError));
    });
  }

  Future<void> _fetchInvitation(
      FetchInvitationEvent event, Emitter<AdminMembersState> emit) async {
    emit(state.copyWith(fetchInvitationStatus: Status.loading));
    try {
      List<Invitation> invitation = await _invitationService
          .fetchSpaceInvitations(spaceId: _userStateNotifier.currentSpaceId!);
      emit(state.copyWith(
          fetchInvitationStatus: Status.success, invitation: invitation));
    } on Exception {
      emit(state.copyWith(
          fetchInvitationStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _showMembersLoading(
      ShowLoadingEvent event, Emitter<AdminMembersState> emit) async {
    emit(state.copyWith(fetchMemberStatus: Status.loading));
  }

  Future<void> _showError(
      ShowErrorEvent event, Emitter<AdminMembersState> emit) async {
    emit(state.copyWith(fetchMemberStatus: Status.error, error: event.error));
  }

  Future<void> _updateMembersList(
      ShowUpdatedMemberEvent event, Emitter<AdminMembersState> emit) async {
    emit(state.copyWith(
        fetchMemberStatus: Status.success, members: event.members));
  }

  @override
  Future<void> close() async {
    await _membersDBSubscription?.cancel();
    return super.close();
  }
}
