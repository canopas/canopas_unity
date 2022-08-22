import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee_leave_count/employee_leave_count.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class EmployeeLeaveCountBlock {

  final UserLeaveService _userLeaveService;
  final UserManager _userManager;

  EmployeeLeaveCountBlock(this._userManager, this._userLeaveService);

  final _leaveCounts = BehaviorSubject<LeaveCounts>.seeded(LeaveCounts(availableLeaveCount: 0, usedLeaveCount: 0, allLeaveCount: 0));

  get leaveCounts => _leaveCounts;

  fetchLeaveSummary() async {
    var _usedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(
        _userManager.employeeId);
    var _allLeaveCount = await _userLeaveService.getUserAllLeaveCount();
    var _availableLeaveCount = _allLeaveCount - _usedLeaveCount;
    _leaveCounts.sink.add(LeaveCounts(availableLeaveCount: _availableLeaveCount,
        usedLeaveCount: _usedLeaveCount,
        allLeaveCount: _allLeaveCount));
  }
}

