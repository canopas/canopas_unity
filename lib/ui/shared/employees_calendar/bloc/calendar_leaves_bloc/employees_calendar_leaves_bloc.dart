import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';

import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/model/leave_application.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/leave_service.dart';
import 'employees_calendar_leaves_state.dart';
import 'employees_calender_leaves_event.dart';

@Injectable()
class EmployeesCalendarLeavesBloc
    extends Bloc<EmployeesCalendarLeavesEvent, EmployeesCalendarLeavesState> {
  final EmployeeService _employeeService;
  final UserManager _userManager;
  final LeaveService _adminLeaveService;
  List<LeaveApplication> _allLeaveRef = [];

  EmployeesCalendarLeavesBloc(
      this._employeeService, this._adminLeaveService, this._userManager)
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

  bool get isAdmin => _userManager.isAdmin;

  _loadData(EmployeeCalenadarLeavesInitialLoadEvent event,
      Emitter<EmployeesCalendarLeavesState> emit) async {
    emit(EmployeesCalendarLeavesLoadingState());
    List<Leave> leaves = await _adminLeaveService.getAllLeaves();
    List<Employee> employees = await _employeeService.getEmployees();
    try {
      _allLeaveRef = leaves
          .map((leave) {
            final employee =
                employees.firstWhereOrNull((emp) => emp.uid == leave.uid);
            return (employee == null)
                ? null
                : LeaveApplication(employee: employee, leave: leave);
          })
          .whereNotNull()
          .toList();
      emit(EmployeesCalendarLeavesSuccessState(
          leaveApplications: _getSelectedDatesLeaves(DateTime.now())));
    } catch (_) {
      emit(EmployeesCalendarLeavesFailureState(firestoreFetchDataError));
    }
  }

  List<LeaveApplication> getEvents(DateTime day) => _allLeaveRef
      .where((la) => la.leave.findUserOnLeaveByDate(day: day))
      .toList();
}
