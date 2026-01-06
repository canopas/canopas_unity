import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/repo/employee_repo.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';
import 'member_list_event.dart';
import 'member_list_state.dart';

@Injectable()
class AdminMembersBloc extends Bloc<AdminMembersEvents, AdminMembersState> {
  final EmployeeRepo _employeeRepo;
  final UserStateNotifier _userStateNotifier;
  final InvitationService _invitationService;

  AdminMembersBloc(
    this._employeeRepo,
    this._invitationService,
    this._userStateNotifier,
  ) : super(const AdminMembersState()) {
    on<AdminMembersInitialLoadEvent>(_onPageLoad);
    on<CancelUserInvitation>(_cancelInvitation);
    on<ExpansionChangeEvent>(_changeExpansion);
  }

  Future<void> _onPageLoad(
    AdminMembersInitialLoadEvent event,
    Emitter<AdminMembersState> emit,
  ) async {
    emit(
      state.copyWith(
        memberFetchStatus: Status.loading,
        invitationFetchStatus: Status.loading,
      ),
    );
    try {
      _invitationService
          .fetchSpaceInvitations(spaceId: _userStateNotifier.currentSpaceId!)
          .then(
            (invitation) => emit(
              state.copyWith(
                invitation: invitation,
                invitationFetchStatus: Status.success,
              ),
            ),
          );
    } on Exception {
      emit(
        state.copyWith(
          error: firestoreFetchDataError,
          invitationFetchStatus: Status.error,
        ),
      );
    }
    try {
      return emit.forEach(
        _employeeRepo.employees,
        onData: (List<Employee> members) => state.copyWith(
          activeMembers: members
              .where((emp) => emp.status == EmployeeStatus.active)
              .toList(),
          inactiveMembers: members
              .where((emp) => emp.status == EmployeeStatus.inactive)
              .toList(),
          memberFetchStatus: Status.success,
        ),
        onError: (error, stackTrace) => state.copyWith(
          error: firestoreFetchDataError,
          memberFetchStatus: Status.error,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          error: firestoreFetchDataError,
          memberFetchStatus: Status.error,
        ),
      );
    }
  }

  void _changeExpansion(
    ExpansionChangeEvent event,
    Emitter<AdminMembersState> emit,
  ) {
    if (state.expanded.contains(event.id)) {
      List<int> list = [...state.expanded];
      list.remove(event.id);
      emit(state.copyWith(expanded: list));
    } else {
      final list = [...state.expanded, event.id];
      emit(state.copyWith(expanded: list));
    }
  }

  Future<void> _cancelInvitation(
    CancelUserInvitation event,
    Emitter<AdminMembersState> emit,
  ) async {
    emit(state.copyWith(invitationFetchStatus: Status.loading));
    try {
      await _invitationService.deleteInvitation(id: event.id);
      final invitation = await _invitationService.fetchSpaceInvitations(
        spaceId: _userStateNotifier.currentSpaceId!,
      );
      emit(
        state.copyWith(
          invitation: invitation,
          invitationFetchStatus: Status.success,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          error: firestoreFetchDataError,
          invitationFetchStatus: Status.error,
        ),
      );
    }
  }
}
