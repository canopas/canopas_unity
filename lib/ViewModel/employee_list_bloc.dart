import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/model/employee.dart';
import 'package:projectunity/services/network_repository.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class EmployeeListBloc {
  final NetworkRepository _networkRepository;

  EmployeeListBloc(this._networkRepository);

  final BehaviorSubject<ApiResponse<List<Employee>>> _employeeList =
      BehaviorSubject<ApiResponse<List<Employee>>>();

  Stream<ApiResponse<List<Employee>>> get allEmployee => _employeeList.stream;

  getEmployeeList() async {
    _employeeList.sink.add(const ApiResponse.loading());
    try {
      List<Employee> list = await _networkRepository.getEmployeeListFromRepo();
      _employeeList.sink.add(ApiResponse.completed(data: list));

    } on Exception catch (error) {
      _employeeList.sink.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _employeeList.close();
  }
}
