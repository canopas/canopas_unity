import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
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
      this._employeeRepo, this._invitationService, this._userStateNotifier)
      : super(const AdminMembersState()) {
    on<AdminMembersInitialLoadEvent>(_onPageLoad);
  }

  Future<void> _onPageLoad(AdminMembersInitialLoadEvent event,
      Emitter<AdminMembersState> emit) async {
    emit(state.copyWith(
        memberFetchStatus: Status.loading,
        invitationFetchStatus: Status.loading));
    try {
      _invitationService
          .fetchSpaceInvitations(spaceId: _userStateNotifier.currentSpaceId!)
          .then((invitation) => emit(state.copyWith(
              invitation: invitation, invitationFetchStatus: Status.success)));
    } on Exception {
      emit(state.copyWith(
          error: firestoreFetchDataError, invitationFetchStatus: Status.error));
    }
    return emit.forEach(_employeeRepo.employees,
        onData: (List<Employee> members) =>
            state.copyWith(members: members, memberFetchStatus: Status.success),
        onError: (error, stackTrace) => state.copyWith(
            error: firestoreFetchDataError, memberFetchStatus: Status.error));
  }
}
