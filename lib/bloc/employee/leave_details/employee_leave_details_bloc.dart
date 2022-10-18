import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../event_bus/events.dart';
import '../../../model/leave/leave.dart';
import '../../../model/remaining_leave.dart';
import '../../../provider/user_data.dart';
import '../../../services/admin/paid_leave/paid_leave_service.dart';
import '../../../services/leave/user_leave_service.dart';

@Injectable()
class EmployeeLeaveDetailsBloc extends BaseBLoc{

  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;
  final UserManager _userManager;
  final NavigationStackManager _stackManager;

  EmployeeLeaveDetailsBloc(this._userLeaveService, this._paidLeaveService, this._userManager, this._stackManager);

  final BehaviorSubject<RemainingLeave> _remainingLeave =
  BehaviorSubject<RemainingLeave>.seeded(
      RemainingLeave(remainingLeave: 0, remainingLeavePercentage: 0.0));

  Stream<RemainingLeave> get remainingLeaveStream => _remainingLeave.stream;

  _fetchUserRemainingLeaveDetails() async {
    int _paidLeaves = 0;
    double _userUsedLeaveCount = 0.0;
    double _remainingLeaveRef = 0.0;

    _paidLeaves = await _paidLeaveService.getPaidLeaves();
    _userUsedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(_userManager.employeeId);
    _remainingLeaveRef = (_paidLeaves - _userUsedLeaveCount) < 0? 0.0 : _paidLeaves - _userUsedLeaveCount;
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


  void removeLeaveRequest({required Leave leave}){
    _userLeaveService.deleteLeaveRequest(leave.leaveId);
    eventBus.fire(LeaveUpdateEventListener(leave));
    _stackManager.pop();
  }

  @override
  void detach() {
    _remainingLeave.close();
  }

  @override
  void attach() {
    _fetchUserRemainingLeaveDetails();
  }
}

