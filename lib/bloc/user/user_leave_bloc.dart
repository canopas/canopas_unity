import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/leave_screen_type_map.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../provider/user_data.dart';
import '../../../../services/leave/user_leave_service.dart';

@Singleton()
class UserLeavesBloc {
  final UserManager _userManager;
  final UserLeaveService _userLeaveService;

  UserLeavesBloc(this._userLeaveService, this._userManager);

  var _leaveList = BehaviorSubject<ApiResponse<List<Leave>>>();

  BehaviorSubject<ApiResponse<List<Leave>>> get leaveList => _leaveList;

  List<Leave> _leaves = <Leave>[];

  void getUserLeaves({required int leaveScreenType}) async {
    if (_leaveList.isClosed) {
      _leaveList = BehaviorSubject<ApiResponse<List<Leave>>>();
    }
    _leaveList.add(const ApiResponse.loading());
    try {
      String employeeId = _userManager.employeeId;
      if (leaveScreenType == LeaveScreenType.allLeaves) {
        _leaves = await _userLeaveService.getAllLeavesOfUser(employeeId);
      } else if (leaveScreenType == LeaveScreenType.requestedLeave){
      _leaves = await _userLeaveService.getRequestedLeave(employeeId);
      } else {
        _leaves = await _userLeaveService.getUpcomingLeaves(employeeId);
      }
      _leaveList.add(ApiResponse.completed(data: _leaves));
    } on Exception catch (error) {
      leaveList.add(ApiResponse.error(message: error.toString()));
    }
  }

  void cancelLeave({required Leave leave}) {
    if (_leaves.contains(leave)) {
      _userLeaveService.deleteLeaveRequest(leave.leaveId);
      _leaves.remove(leave);
      _leaveList.add(ApiResponse.completed(data: _leaves));
    }
  }

  void dispose() {
    _leaveList.close();
    _leaves.clear();
  }
}
