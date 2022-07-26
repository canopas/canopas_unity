import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../provider/user_data.dart';
import '../../../../services/leave/user_leave_service.dart';

@Singleton()
class UserAllLeavesBloc {
  final UserManager _userManager;
  final UserLeaveService _applyLeaveService;

  UserAllLeavesBloc(this._applyLeaveService, this._userManager);

  final BehaviorSubject<ApiResponse<List<Leave>>> _allLeaves =
      BehaviorSubject<ApiResponse<List<Leave>>>();

  BehaviorSubject<ApiResponse<List<Leave>>> get allLeaves => _allLeaves;

  void getAllLeaves() async {
    String? id = _userManager.employeeId;

    _allLeaves.add(const ApiResponse.loading());
    try {
      final List<Leave> leaves =
          await _applyLeaveService.getAllLeavesOfUser(id);
      _allLeaves.add(ApiResponse.completed(data: leaves));
    } on Exception catch (error) {
      _allLeaves.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _allLeaves.close();
  }
}
