import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/model/employee_leave_count/employee_leave_count.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:rxdart/rxdart.dart';

@Injectable()
class EmployeeHomeBLoc extends BaseBLoc {
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;

  EmployeeHomeBLoc(this._userManager, this._userLeaveService);

  final _leaveCounts = BehaviorSubject<LeaveCounts>.seeded(LeaveCounts());

  BehaviorSubject get leaveCounts => _leaveCounts;

  _fetchLeaveSummary() async {
    if (leaveCounts.isClosed) return;

    var usedLeaveCount =
        await _userLeaveService.getUserUsedLeaveCount(_userManager.employeeId);
    var allLeaveCount = await _userLeaveService.getUserAllLeaveCount();

    var availableLeaveCount =
        allLeaveCount < usedLeaveCount ? 0 : allLeaveCount - usedLeaveCount;

    _leaveCounts.sink.add(LeaveCounts(
        availableLeaveCount: availableLeaveCount,
        usedLeaveCount: usedLeaveCount,
        allLeaveCount: allLeaveCount));
  }

  @override
  void attach() {
    _fetchLeaveSummary();
  }

  @override
  void detach() async {
    await _leaveCounts.drain();
    _leaveCounts.close();
  }
}
