import 'package:injectable/injectable.dart';
import 'package:projectunity/services/leave/admin_leave_service.dart';

@Singleton()
class UpdateLeaveStatus {
  final AdminLeaveService _adminLeaveService;

  UpdateLeaveStatus(this._adminLeaveService);

  int _leaveStatus = 1;
  String? _reason;

  int get leaveStatus => _leaveStatus;

  void updateStatus(int status) {
    _leaveStatus = status;
  }

  String? get reason => _reason;

  void setReason(String? value) {
    _reason = value;
  }

  void addLeaveApproval(String leaveId) {
    if (_leaveStatus == 1) {
      return;
    } else if (_leaveStatus != 1 && reason == null) {
      return;
    }
    Map<String, dynamic> map = <String, dynamic>{
      'leaveStatus': _leaveStatus,
      'rejectionReason': reason
    };
    _adminLeaveService.updateLeaveStatus(leaveId, map);
  }
}
