import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../services/employee/employee_service.dart';

@Injectable()
class EmployeeListBloc extends BaseBLoc {
  final EmployeeService _employeeService;

  EmployeeListBloc(this._employeeService);

  final BehaviorSubject<ApiResponse<List<Employee>>> _employeeList =
      BehaviorSubject<ApiResponse<List<Employee>>>();

  BehaviorSubject<ApiResponse<List<Employee>>> get allEmployees => _employeeList;

  Future<void> _getEmployeeList() async {
    _employeeList.sink.add(const ApiResponse.loading());
    try {
      List<Employee> list = await _employeeService.getEmployees();
      _employeeList.sink.add(ApiResponse.completed(data: list));
    } on Exception catch (_) {
      _employeeList.sink
          .add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  @override
  void attach() {
    _getEmployeeList();
  }

  @override
  void detach() {
    _employeeList.close();
  }
}
