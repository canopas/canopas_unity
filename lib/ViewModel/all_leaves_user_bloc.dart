import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/model/Leave/leave_detail.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/network_repository.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class AllLeavesUserBloc {
  final NetworkRepository _networkRepository;

  AllLeavesUserBloc(this._networkRepository);

  Future getEmployeeList(int index) async {
    List<Employee> employeeList =
        await _networkRepository.getEmployeeListFromRepo();
    employeeList.map((e) {
      if (e.employeeId == index) ;
      print(e.name);
      return e;
    });
  }

  final _allLeaves = BehaviorSubject<ApiResponse<LeaveDetail>>();

  BehaviorSubject<ApiResponse<LeaveDetail>> get allLeavesOfUser => _allLeaves;

  getAllLeaves() async {
    _allLeaves.sink.add(const ApiResponse.loading());
    try {
      LeaveDetail leaveDetail =
          await _networkRepository.getLeavesOfUserFromRepo();
      _allLeaves.sink.add(ApiResponse.completed(data: leaveDetail));
    } on Exception catch (error) {
      _allLeaves.sink.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _allLeaves.close();
  }
}
