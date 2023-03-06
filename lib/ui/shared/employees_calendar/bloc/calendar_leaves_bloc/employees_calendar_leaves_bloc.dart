import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:projectunity/exception/error_const.dart';

import '../../../../../model/employee/employee.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../model/leave_application.dart';
import '../../../../../services/employee_service.dart';
import '../../../../../services/leave_service.dart';
import 'employees_calendar_leaves_state.dart';
import 'employees_calender_leaves_event.dart';

@Injectable()
class EmployeesCalendarLeavesBloc
    extends Bloc<EmployeesCalendarLeavesEvent, EmployeesCalendarLeavesState> {
  final EmployeeService _employeeService;
  final LeaveService _adminLeaveService;
  List<LeaveApplication> _allLeaveRef = [];

  EmployeesCalendarLeavesBloc(this._employeeService, this._adminLeaveService)
      : super(EmployeesCalendarLeavesInitialState()) {
    on<GetSelectedDateLeavesEvent>(_onSelectDate);
    on<EmployeeCalenadarLeavesInitialLoadEvent>(_loadData);
  }

  _onSelectDate(GetSelectedDateLeavesEvent event,
      Emitter<EmployeesCalendarLeavesState> emit) async {
    emit(EmployeesCalendarLeavesSuccessState(
        leaveApplications: _getSelectedDatesLeaves(event.selectedDate)));
  }

  List<LeaveApplication> _getSelectedDatesLeaves(DateTime day) {
    return _allLeaveRef
        .where((la) => la.leave.findUserOnLeaveByDate(day: day))
        .toList();
  }

  _loadData(EmployeeCalenadarLeavesInitialLoadEvent event,
      Emitter<EmployeesCalendarLeavesState> emit) async {
    emit(EmployeesCalendarLeavesLoadingState());
    List<Leave> leaves = await _adminLeaveService.getAllLeaves();
    List<Employee> employees = await _employeeService.getEmployees();
    try {
      _allLeaveRef = leaves
          .map((leave) {
            final employee =
                employees.firstWhereOrNull((emp) => emp.id == leave.uid);
            return (employee == null)
                ? null
                : LeaveApplication(employee: employee, leave: leave);
          })
          .whereNotNull()
          .toList();
      emit(EmployeesCalendarLeavesSuccessState(
          leaveApplications: _getSelectedDatesLeaves(DateTime.now())));
    } on Exception catch (_) {
      emit(EmployeesCalendarLeavesFailureState(firestoreFetchDataError));
    }
  }

  List<LeaveApplication> getEvents(DateTime day) => _allLeaveRef
      .where((la) => la.leave.findUserOnLeaveByDate(day: day))
      .toList();
}
