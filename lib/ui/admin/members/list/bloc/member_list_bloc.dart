import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/services/employee_service.dart';
import 'member_list_event.dart';
import 'member_list_state.dart';

@Injectable()
class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeService _employeeService;
  final UserStateNotifier _userStateNotifier;
  final InvitationService _invitationService;
  StreamSubscription? _subscription;

  EmployeeListBloc(
      this._employeeService, this._invitationService, this._userStateNotifier)
      : super(EmployeeListInitialState()) {
    on<EmployeeListInitialLoadEvent>(_onPageLoad);
    _subscription =
        eventBus.on<EmployeeListUpdateEvent>().listen((event) async {
      add(EmployeeListInitialLoadEvent());
    });
  }

  Future<void> _onPageLoad(EmployeeListInitialLoadEvent event,
      Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoadingState());
    try {
      List<Employee> employees = await _employeeService.getEmployees();
      List<Invitation> invitation = await _invitationService
          .fetchSpaceInvitations(spaceId: _userStateNotifier.currentSpaceId!);
      emit(EmployeeListSuccessState(
          employees: employees, invitation: invitation));
    } on Exception {
      emit(const EmployeeListFailureState(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
