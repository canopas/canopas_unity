import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/navigation/nav_stack_item.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../exception/error_const.dart';
import '../../../navigation/navigation_stack_manager.dart';

@Injectable()
class EmployeeDetailBloc extends BaseBLoc {
  final EmployeeService _service;
  final NavigationStackManager stateManager;

  EmployeeDetailBloc(this._service, this.stateManager);

  final BehaviorSubject<ApiResponse<Employee>> _employee =
      BehaviorSubject<ApiResponse<Employee>>();

  BehaviorSubject<ApiResponse<Employee>> get employeeDetail => _employee;

  Future<void> getEmployeeDetailByID(String id) async {
    _employee.sink.add(const ApiResponse.loading());
    try {
      Employee? employee = await _service.getEmployee(id);
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
    _service.deleteEmployee(id);
    stateManager.clearAndPush(const NavStackItem.adminHome());
  }

  @override
  void detach() {
    _employee.close();
  }

  @override
  void attach() {}
}
