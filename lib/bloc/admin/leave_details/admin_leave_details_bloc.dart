import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/services/leave/paid_leave_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../../model/admin_leave_details/admin_remaining_leave_model.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../services/leave/admin_leave_service.dart';
import '../../../services/leave/user_leave_service.dart';

@Injectable()
class AdminLeaveDetailsScreenBloc extends BaseBLoc {
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;
  final NavigationStackManager _stackManager;
  final AdminLeaveService _adminLeaveService;

  AdminLeaveDetailsScreenBloc(this._userLeaveService, this._paidLeaveService,
      this._stackManager, this._adminLeaveService);

  final BehaviorSubject<RemainingLeave> _remainingLeave =
      BehaviorSubject<RemainingLeave>.seeded(
          RemainingLeave(remainingLeave: 0, remainingLeavePercentage: 0.0));

  Stream<RemainingLeave> get remainingLeaveStream => _remainingLeave.stream;

  fetchUserRemainingLeaveDetails({required String id}) async {
    int _paidLeaves = 0;
    double _userUsedLeaveCount = 0.0;
    double _remainingLeaveRef = 0.0;

    _paidLeaves = await _paidLeaveService.getPaidLeaves();
    _userUsedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(id);
    _remainingLeaveRef = (_paidLeaves - _userUsedLeaveCount) < 0 ? 0.0 : _paidLeaves - _userUsedLeaveCount;
    double _percentage = (100 - (100 / _paidLeaves) * _remainingLeaveRef) / 100;
    if (_percentage > 1) {
      _percentage = 1;
    } else if (_percentage < 0) {
      _percentage = 0.0;
    }
    _remainingLeave.add(RemainingLeave(
        remainingLeave: _remainingLeaveRef,
        remainingLeavePercentage: _percentage));
  }

  rejectOrApproveLeaveRequest(
      {required String reason, required String leaveId, required leaveStatus}) {
    Map<String, dynamic> map = _setLeaveApproval(leaveStatus, reason);
    _adminLeaveService.updateLeaveStatus(leaveId, map);
    _stackManager.pop();
  }

  Map<String, dynamic> _setLeaveApproval(int leaveStatus, String reason) {
    Map<String, dynamic> map = <String, dynamic>{
      'leave_status': leaveStatus,
      'rejectionReason': reason,
    };
    return map;
  }

  @override
  void detach() {
    _remainingLeave.close();
  }

  @override
  void attach() {}
}
