import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../exception/error_const.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../services/admin/employee/employee_service.dart';

@Injectable()
class EmployeeDetailBloc extends BaseBLoc {
  final EmployeeService _employeeService;
  final UserLeaveService _userLeaveService;
  final NavigationStackManager stateManager;

  EmployeeDetailBloc(this._employeeService, this.stateManager,this._userLeaveService);

  final BehaviorSubject<ApiResponse<Employee>> _employee =
      BehaviorSubject<ApiResponse<Employee>>();

  BehaviorSubject<ApiResponse<Employee>> get employeeDetail => _employee;

  Future<void> getEmployeeDetailByID(String id) async {
    _employee.sink.add(const ApiResponse.loading());
    try {
      Employee? employee = await _employeeService.getEmployee(id);
      if (employee == null) {
        _employee.sink
            .add(const ApiResponse.error(error: firestoreFetchDataError));
      }
      _employee.sink.add(ApiResponse.completed(data: employee!));
    } on Exception {
      _employee.sink.add(const ApiResponse.error(error: undefinedError));
    }
  }

  void deleteEmployee(String id) async {
    await _employeeService.deleteEmployee(id).then((value) {
      _userLeaveService.deleteAllLeaves(id);
    });
    stateManager.clearAndPush(const NavStackItem.adminHome());
  }

  @override
  void detach() {
    _employee.close();
  }

  @override
  void attach() {}
}
