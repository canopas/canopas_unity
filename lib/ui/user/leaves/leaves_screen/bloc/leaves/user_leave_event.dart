abstract class UserLeavesEvents {}

class LoadInitialUserLeaves extends UserLeavesEvents {}

class FetchMoreUserLeaves extends UserLeavesEvents {}

class UpdateLeave extends UserLeavesEvents {
  final String leaveId;

  UpdateLeave({required this.leaveId});
}
