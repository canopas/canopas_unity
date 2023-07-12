import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/leave_service.dart';
import 'employee_detail_event.dart';
import 'employee_detail_state.dart';

@Injectable()
class EmployeeDetailBloc
    extends Bloc<EmployeeDetailEvent, AdminEmployeeDetailState> {
  final LeaveService _leaveService;
  final EmployeeService _employeeService;
  final UserStateNotifier _userManager;
  final AccountService _accountService;
  final SpaceService _spaceService;
  late StreamSubscription _subscription;

  EmployeeDetailBloc(this._accountService, this._spaceService,
      this._userManager, this._employeeService, this._leaveService)
      : super(EmployeeDetailInitialState()) {
    _subscription =
        eventBus.on<EmployeeDetailInitialLoadEvent>().listen((event) {
      add(EmployeeDetailInitialLoadEvent(employeeId: event.employeeId));
    });
    on<EmployeeDetailInitialLoadEvent>(_onInitialLoad);
    on<DeactivateEmployeeEvent>(_onDeactivateEmployeeEvent);
  }

  Future<void> _onInitialLoad(EmployeeDetailInitialLoadEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {
    emit(EmployeeDetailLoadingState());

    try {
      Employee? employee = await _employeeService.getEmployee(event.employeeId);
      final double usedLeaves =
          await _leaveService.getUserUsedLeaves(event.employeeId);
      final int totalLeaves = await _spaceService.getPaidLeaves(
          spaceId: _userManager.currentSpaceId!);
      double percentage = 0.0;
      if (totalLeaves != 0) {
        percentage = usedLeaves / totalLeaves;
      }
      if (employee != null) {
        emit(EmployeeDetailLoadedState(
            employee: employee,
            timeOffRatio: percentage,
            usedLeaves: usedLeaves));
      } else {
        emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
      }
    } on Exception {
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
    }
  }

  Future<void> _onDeactivateEmployeeEvent(DeactivateEmployeeEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {
    try {
      await _employeeService.changeAccountStatus(
          id: event.employeeId, status: EmployeeStatus.inactive);
      await _accountService.deleteSpaceIdFromAccount(
          spaceId: _userManager.currentSpaceId!, uid: event.employeeId);
    } on Exception {
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
