import 'package:injectable/injectable.dart';
import 'package:projectunity/ViewModel/api_response.dart';
import 'package:projectunity/model/employee.dart';
import 'package:projectunity/services/network_repository.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class EmployeeListBloc {
  final NetworkRepository _networkRepository;

  EmployeeListBloc(this._networkRepository);

  final BehaviorSubject<ApiResponse<List<Employee>>> _employeeList =
      BehaviorSubject<ApiResponse<List<Employee>>>();

  BehaviorSubject<ApiResponse<List<Employee>>> get allEmployee => _employeeList;

  getEmployeeList() async {
    try {
      List<Employee> list = await _networkRepository.getEmployeeListFromRepo();
      _employeeList.sink.add(ApiResponse.completed(list));
    } catch (error) {
      _employeeList.sink.addError(ApiResponse.error(error.toString()));
    }
  }

  void dispose() {
    _employeeList.close();
  }
}
