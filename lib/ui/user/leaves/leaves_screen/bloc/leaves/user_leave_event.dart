import '../../../../../../data/model/leave/leave.dart';

abstract class UserLeavesEvents {
  const UserLeavesEvents();
}

class ListenUserLeaves extends UserLeavesEvents {
  final int year;

  const ListenUserLeaves({required this.year});
}

class ShowUserLeaves extends UserLeavesEvents {
  final List<Leave> leaves;

  const ShowUserLeaves(this.leaves);
}

class ShowError extends UserLeavesEvents {
  const ShowError();
}
