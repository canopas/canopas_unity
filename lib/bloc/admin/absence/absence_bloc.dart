import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../exception/error_const.dart';
import '../../../model/employee/employee.dart';
import '../../../model/leave/leave.dart';
import '../../../services/admin/employee/employee_service.dart';
import '../../../services/admin/requests/admin_leave_service.dart';

@Injectable()
class AbsenceBloc extends BaseBLoc {
  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;

  AbsenceBloc(this._employeeService, this._adminLeaveService);

  final BehaviorSubject<ApiResponse<List<LeaveApplication>>> _absenceEmployees =
      BehaviorSubject<ApiResponse<List<LeaveApplication>>>();

  Stream<ApiResponse<List<LeaveApplication>>> get absenceEmployee =>
      _absenceEmployees;

  _getAbsenceEmployees() async {
    _absenceEmployees.add(const ApiResponse.loading());

    List<Employee> employees = await _employeeService.getEmployees();
    List<Leave> absenceLeaves = await _adminLeaveService.getAllAbsence();
    try {
      List<LeaveApplication> absenceEmployee = absenceLeaves
          .map((leave) {
            final employee =
                employees.firstWhereOrNull((emp) => emp.id == leave.uid);
            return (employee == null)
                ? null
                : LeaveApplication(employee: employee, leave: leave);
          })
          .whereNotNull()
          .toList();
      _absenceEmployees.add(ApiResponse.completed(data: absenceEmployee));
    } on Exception catch (_) {
      _absenceEmployees
          .add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  @override
  void attach() async {
    await _getAbsenceEmployees();
  }

  @override
  void detach() {
    _absenceEmployees.close();
  }
}
