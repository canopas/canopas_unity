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
    _employeeList.sink.add(ApiResponse.loading());
    try {
      List<Employee> list = await _networkRepository.getEmployeeListFromRepo();
      _employeeList.sink.add(ApiResponse.completed(data: list));
    } catch (error) {
      _employeeList.sink.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _employeeList.close();
  }
}
