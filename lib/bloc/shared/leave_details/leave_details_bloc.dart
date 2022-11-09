import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../event_bus/events.dart';
import '../../../model/leave/leave.dart';
import '../../../model/remaining_leave.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../provider/user_data.dart';
import '../../../services/admin/paid_leave/paid_leave_service.dart';
import '../../../services/admin/requests/admin_leave_service.dart';
import '../../../services/leave/user_leave_service.dart';

@Injectable()
class LeaveDetailBloc extends BaseBLoc {
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;
  final NavigationStackManager _stackManager;
  final AdminLeaveService _adminLeaveService;
  final UserManager _userManager;

  LeaveDetailBloc(this._userLeaveService, this._paidLeaveService,
      this._stackManager, this._adminLeaveService, this._userManager);

  final BehaviorSubject<RemainingLeave> _remainingLeave =
  BehaviorSubject<RemainingLeave>.seeded(
      RemainingLeave(remainingLeave: 0, remainingLeavePercentage: 0.0));

  Stream<RemainingLeave> get remainingLeaveStream => _remainingLeave.stream;

  String get currentUserId => _userManager.employeeId;
  bool get currentUserIsAdmin => _userManager.isAdmin;

  fetchUserRemainingLeaveDetails({required String id}) async {
    int paidLeaves = 0;
    double userUsedLeaveCount = 0.0;
    double remainingLeaveRef = 0.0;
    double percentage = 1;

    paidLeaves = await _paidLeaveService.getPaidLeaves();
    userUsedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(id);
    remainingLeaveRef = (paidLeaves - userUsedLeaveCount) < 0
        ? 0.0
        : paidLeaves - userUsedLeaveCount;
    if(paidLeaves != 0){
       percentage = (100 - (100 / paidLeaves) * remainingLeaveRef) / 100;
    }
    if (percentage > 1) {
      percentage = 1;
    } else if (percentage < 0) {
      percentage = 0.0;
    }
    _remainingLeave.add(RemainingLeave(
        remainingLeave: remainingLeaveRef,
        remainingLeavePercentage: percentage));
  }

  void rejectOrApproveLeaveRequest(
      {required String reason, required String leaveId, required leaveStatus}) {
    Map<String, dynamic> map = _setLeaveApproval(leaveStatus, reason);
    _adminLeaveService.updateLeaveStatus(leaveId, map);
    _stackManager.pop();
  }

  void removeLeaveRequest({required Leave leave}){
    _userLeaveService.deleteLeaveRequest(leave.leaveId);
    eventBus.fire(LeaveUpdateEventListener(leave));
    _stackManager.pop();
  }

  Map<String, dynamic> _setLeaveApproval(int leaveStatus, String reason) {
    Map<String, dynamic> map = <String, dynamic>{
      'leave_status': leaveStatus,
      'rejection_reason': reason,
    };
    return map;
  }

  @override
  void detach() {
    _remainingLeave.close();
  }

  @override
  void attach() {
  }
}
