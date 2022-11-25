import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import '../../../event_bus/events.dart';
import '../../../model/leave/leave.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../provider/user_data.dart';
import '../../../services/admin/requests/admin_leave_service.dart';
import '../../../services/leave/user_leave_service.dart';

@Injectable()
class LeaveDetailBloc extends BaseBLoc {
  final UserLeaveService _userLeaveService;
  final NavigationStackManager _stackManager;
  final AdminLeaveService _adminLeaveService;
  final UserManager _userManager;

  LeaveDetailBloc(this._userLeaveService,
      this._stackManager, this._adminLeaveService, this._userManager);

  String get currentUserId => _userManager.employeeId;
  bool get currentUserIsAdmin => _userManager.isAdmin;

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

   void  onUserContentTap({required String id}){
    _stackManager.push(NavStackItem.employeeDetailState(id: id));
  }

  Map<String, dynamic> _setLeaveApproval(int leaveStatus, String reason) {
    Map<String, dynamic> map = <String, dynamic>{
      'leave_status': leaveStatus,
      'rejection_reason': reason,
    };
    return map;
  }

  @override
  void detach() {}

  @override
  void attach() {}
}
