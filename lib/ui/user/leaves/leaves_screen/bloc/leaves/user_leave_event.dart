import 'package:projectunity/data/model/leave/leave.dart';

abstract class UserLeavesEvents {}

class LoadInitialUserLeaves extends UserLeavesEvents {}

class FetchMoreUserLeaves extends UserLeavesEvents {
  final LeaveType leaveType;

  FetchMoreUserLeaves(this.leaveType);
}

class UpdateLeave extends UserLeavesEvents {
  final String leaveId;

  UpdateLeave({required this.leaveId});
}
