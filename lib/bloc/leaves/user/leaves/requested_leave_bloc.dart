import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../rest/api_response.dart';

@singleton
class UserRequestedLeaveBloc {
  final UserManager _userManager;
  final UserLeaveService _userLeaveService;

  UserRequestedLeaveBloc(this._userManager, this._userLeaveService);

  final _requestedLeaves = BehaviorSubject<ApiResponse<List<Leave>>>();

  BehaviorSubject<ApiResponse<List<Leave>>> get requestedLeaves =>
      _requestedLeaves;

  void getRequestedLeaves() async {
    String id = _userManager.employeeId;
    _requestedLeaves.add(const ApiResponse.loading());
    try {
      List<Leave>? list = await _userLeaveService.getRequestedLeave(id);
      _requestedLeaves.add(ApiResponse.completed(data: list));
    } on Exception catch (error) {
      _requestedLeaves.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _requestedLeaves.close();
  }
}
