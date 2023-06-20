import '../../../../../data/model/leave_application.dart';

abstract class AdminHomeEvent {
  const AdminHomeEvent();
}

class UpdateLeaveRequestApplicationEvent extends AdminHomeEvent {
  final Map<DateTime, List<LeaveApplication>> leaveRequestMap;

  const UpdateLeaveRequestApplicationEvent(this.leaveRequestMap);
}

class ShowErrorEvent extends AdminHomeEvent {
  final String error;

  const ShowErrorEvent(this.error);
}
