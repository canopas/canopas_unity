import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../services/leave/user_leave_service.dart';

@Singleton()
class UserAllLeavesBloc {
  final UserLeaveService _applyLeaveService;

  UserAllLeavesBloc(this._applyLeaveService);

  final BehaviorSubject<ApiResponse<List<LeaveRequestData>>> _allLeaves =
      BehaviorSubject<ApiResponse<List<LeaveRequestData>>>();

  BehaviorSubject<ApiResponse<List<LeaveRequestData>>> get allLeaves =>
      _allLeaves;

  void getAllLeaves() async {
    String? id = FirebaseAuth.instance.currentUser?.uid;

    _allLeaves.add(const ApiResponse.loading());
    try {
      if (id == null) {
        _allLeaves
            .add(const ApiResponse.error(message: 'Something went wrong'));
      }
      final List<LeaveRequestData> leaves =
          await _applyLeaveService.getAllLeavesOfUser(id!);
      _allLeaves.add(ApiResponse.completed(data: leaves));
    } on Exception catch (error) {
      _allLeaves.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _allLeaves.close();
  }
}
