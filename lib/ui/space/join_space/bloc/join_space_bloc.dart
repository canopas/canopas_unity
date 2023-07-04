import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/data/services/mail_notification_service.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_event.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_state.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/invitation/invitation.dart';
import '../../../../data/model/space/space.dart';
import '../../../../data/services/employee_service.dart';
import '../../../../data/services/invitation_services.dart';
import '../../../../data/services/space_service.dart';

@Injectable()
class JoinSpaceBloc extends Bloc<JoinSpaceEvents, JoinSpaceState> {
  final UserStateNotifier _userManager;
  final EmployeeService _employeeService;
  final SpaceService _spaceService;
  final InvitationService _invitationService;
  final NotificationService _notificationService;
  final AccountService accountService;
  final AuthService _authService;
  late final List<Invitation> invitations;

  JoinSpaceBloc(
      this._invitationService,
      this._spaceService,
      this._userManager,
      this.accountService,
      this._employeeService,
      this._authService,
      this._notificationService,
      this.invitations)
      : super(const JoinSpaceState()) {
    on<JoinSpaceInitialFetchEvent>(_init);
    on<SelectSpaceEvent>(_joinSpace);
    on<JoinRequestedSpaceEvent>(_joinRequestedSpace);
    on<SignOutEvent>(_signOut);
  }

  String get userEmail => _userManager.userEmail ?? "unknown";

  Future<List<Space>> getRequestedSpaces() async {
    invitations = await _invitationService
        .fetchSpaceInvitationsForUserEmail(_userManager.userEmail!);

    return await Future.wait(invitations.map((invitation) async {
      return await _spaceService.getSpace(invitation.spaceId);
    })).then((value) => value.whereNotNull().toList());
  }

  Future<List<Space>> joinedSpace() async {
    final List<String> spaceIds =
        await accountService.fetchSpaceIds(uid: _userManager.userUID!);
    return await Future.wait(spaceIds.map((spaceId) async {
      return await _spaceService.getSpace(spaceId);
    })).then((value) => value.whereNotNull().toList());
  }

  Future<void> _init(
      JoinSpaceInitialFetchEvent event, Emitter<JoinSpaceState> emit) async {
    emit(state.copyWith(fetchSpaceStatus: Status.loading));
    try {
      final requestedSpaces = await getRequestedSpaces();
      final ownSpaces = await joinedSpace();
      emit(state.copyWith(
          fetchSpaceStatus: Status.success,
          ownSpaces: ownSpaces,
          requestedSpaces: requestedSpaces));
    } on Exception {
      emit(state.copyWith(
          fetchSpaceStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _joinSpace(
      SelectSpaceEvent event, Emitter<JoinSpaceState> emit) async {
    emit(state.copyWith(selectSpaceStatus: Status.loading));
    try {
      final employee = await _employeeService.getEmployeeBySpaceId(
          spaceId: event.space.id, userId: _userManager.userUID!);
      if (employee != null) {
        await _userManager.setEmployeeWithSpace(
            space: event.space, spaceUser: employee);
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

  Future<void> _joinRequestedSpace(
      JoinRequestedSpaceEvent event, Emitter<JoinSpaceState> emit) async {
    emit(state.copyWith(selectSpaceStatus: Status.loading));
    try {
      final employee = Employee(
          uid: _userManager.userUID!,
          name: _userManager.userFirebaseAuthName ??
              _userManager.userEmail!.split('.')[0],
          email: _userManager.userEmail!,
          role: Role.employee,
          dateOfJoining: DateTime.now());
      await _employeeService.addEmployeeBySpaceId(
          employee: employee, spaceId: event.space.id);
      await accountService.updateSpaceOfUser(
          spaceID: event.space.id, uid: _userManager.userUID!);
      await _userManager.setEmployeeWithSpace(
          space: event.space, spaceUser: employee);
      final invitation = getSelectedInvitation(event.space.id);
      await _invitationService.deleteInvitation(id: invitation.id);
      await _notificationService.sendInviteAcceptNotificationNotification(
          sender: _userManager.userEmail!,
          receiver: event.space.notificationEmail!);
      emit(state.copyWith(selectSpaceStatus: Status.success));
    } on Exception {
      emit(state.copyWith(
          selectSpaceStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Invitation getSelectedInvitation(String spaceId) {
    return invitations
        .firstWhere((invitation) => invitation.spaceId == spaceId);
  }

  Future<void> _signOut(
      SignOutEvent event, Emitter<JoinSpaceState> emit) async {
    emit(state.copyWith(signOutStatus: Status.loading));
    try {
      bool isLogOut = await _authService.signOutWithGoogle();
      if (isLogOut) {
        await _userManager.removeAll();
        emit(state.copyWith(signOutStatus: Status.success));
      } else {
        throw Exception(signOutError);
      }
    } on Exception {
      emit(state.copyWith(error: signOutError, signOutStatus: Status.error));
    }
  }

  @override
  Future<void> close() {
    invitations.clear();
    return super.close();
  }
}
