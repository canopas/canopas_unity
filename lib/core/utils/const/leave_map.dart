import '../../../model/leave/leave.dart';

Map<int, String> leaveStatusMap = Map.unmodifiable({
  pendingLeaveStatus: 'Pending',
  approveLeaveStatus: 'Approved',
  rejectLeaveStatus: 'Rejected',
});

Map<int, String> leaveTypeMap = Map.unmodifiable({
  0: 'Casual Leave',
  1: 'Sick Leave',
  2: 'Annual Leave',
  3: 'Paternity Leave',
  4: 'Maternity Leave',
  5: 'Marriage Leave',
  6: 'Bereavement Leave'
});
