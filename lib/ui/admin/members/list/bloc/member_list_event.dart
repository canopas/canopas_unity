import '../../../../../data/model/employee/employee.dart';

abstract class AdminMembersEvents {
  const AdminMembersEvents();
}

class FetchInvitationEvent extends AdminMembersEvents {}

class ShowUpdatedMemberEvent extends AdminMembersEvents {
  final List<Employee> members;

  const ShowUpdatedMemberEvent(this.members);
}

class ShowErrorEvent extends AdminMembersEvents {
  final String error;

  const ShowErrorEvent(this.error);
}

class ShowLoadingEvent extends AdminMembersEvents {}
