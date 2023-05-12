abstract class UserLeaveEvents {}

class FetchUserLeaveEvent extends UserLeaveEvents {}

class ChangeYearEvent extends UserLeaveEvents {
  final int year;

  ChangeYearEvent({required this.year});
}
