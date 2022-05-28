import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/model/Leave/leave_detail.dart';
import 'package:projectunity/services/EmployeeApiService/employee_detail_api_service.dart';
import 'package:projectunity/services/EmployeeApiService/employee_list_api_service.dart';
import 'package:projectunity/services/LeaveService/team_leaves_api_service.dart';
import 'package:projectunity/services/LeaveService/user_leaves_api_service.dart';

@Injectable()
class NetworkRepository {
  final EmployeeListApiService _employeeListApiService;
  final EmployeeDetailApiService _employeeDetailByID;
  final UserLeavesApiService _userLeavesApiService;
  final TeamLeavesApiService _teamLeavesApiService;

  NetworkRepository(
      this._employeeListApiService,
      this._employeeDetailByID,
      this._userLeavesApiService,
      this._teamLeavesApiService);

  Future<List<Employee>> getEmployeeListFromRepo() {
    return _employeeListApiService.getEmployeeListFromAPI();
  }

  Future<Employee> getEmployeeDetailFromRepo(int id) {
    return _employeeDetailByID.getEmployeeByID(id);
  }

  Future<LeaveDetail> getLeavesOfUserFromRepo() {
    return _userLeavesApiService.getUserLeaves();
  }

  Future<LeaveDetail> getTeamLeavesFromRepo() {
    return _teamLeavesApiService.getTeamLeaves();
  }
}
