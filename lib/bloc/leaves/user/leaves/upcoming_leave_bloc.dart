import 'package:injectable/injectable.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../model/leave/leave.dart';
import '../../../../rest/api_response.dart';

@singleton
class UpcomingLeaveBloc {
  final UserManager _userManager;
  final UserLeaveService _userLeaveService;

  UpcomingLeaveBloc(this._userManager, this._userLeaveService);

  final _upcomingLeave = BehaviorSubject<ApiResponse<List<Leave>>>();

  BehaviorSubject<ApiResponse<List<Leave>>> get upcomingLeaves =>
      _upcomingLeave;

  void getUpcomingLeaves() async {
    String employeeId = _userManager.employeeId;
    _upcomingLeave.add(const ApiResponse.loading());
    try {
      final List<Leave> list =
          await _userLeaveService.getUpcomingLeaves(employeeId);
      _upcomingLeave.add(ApiResponse.completed(data: list));
    } on Exception catch (error) {
      _upcomingLeave.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _upcomingLeave.close();
  }
}
