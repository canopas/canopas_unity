import 'package:injectable/injectable.dart';
import 'package:projectunity/services/leave/admin_leave_service.dart';

import '../../bloc/admin/leave/leave_application_bloc.dart';
import '../../model/leave/leave.dart';

@Singleton()
class LeaveStatusManager {
  final AdminLeaveService _adminLeaveService;
  final LeaveApplicationBloc leaveApplicationBloc;

  LeaveStatusManager(this._adminLeaveService, this.leaveApplicationBloc);

  int _leaveStatus = pendingLeaveStatus;
  String? _reason;

  int get leaveStatus => _leaveStatus;

  void updateStatus(int status) {
    _leaveStatus = status;
  }

  String? get reason => _reason;

  void setReason(String? value) {
    _reason = value;
  }

  Map<String, dynamic> setLeaveApproval(int leaveStatus, String? reason) {
    Map<String, dynamic> map = <String, dynamic>{
      'leave_status': leaveStatus,
      'rejectionReason': reason
    };
    return map;
  }

  bool leaveApprove(String leaveId) {
    if (_leaveStatus == pendingLeaveStatus) {
      return false;
    } else if (_leaveStatus == rejectLeaveStatus && reason == null) {
      return false;
    }
    Map<String, dynamic> map = setLeaveApproval(_leaveStatus, reason);
    _adminLeaveService.updateLeaveStatus(leaveId, map);
    return true;
  }
}
