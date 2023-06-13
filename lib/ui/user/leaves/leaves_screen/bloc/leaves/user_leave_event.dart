abstract class UserLeaveEvents {}

class UserLeavesShowLeavesChangesEvent extends UserLeaveEvents {}
class UserLeavesShowLoadingEvent extends UserLeaveEvents {}
class UserLeavesShowErrorEvent extends UserLeaveEvents {
  final String error;
  UserLeavesShowErrorEvent(this.error);
}

class ChangeYearEvent extends UserLeaveEvents {
  final int year;
  ChangeYearEvent({required this.year});
}
