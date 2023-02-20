import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class AdminLeaveApplicationDetailsEvents extends Equatable {}

class AdminLeaveRequestDetailsInitialLoadEvents extends AdminLeaveApplicationDetailsEvents{
  final LeaveApplication leaveApplication;
  AdminLeaveRequestDetailsInitialLoadEvents({required this.leaveApplication});
  @override
  List<Object?> get props => [leaveApplication];
}

class AdminLeaveApplicationDetailsApproveRequestEvent extends AdminLeaveApplicationDetailsEvents {
  final String leaveId;
  AdminLeaveApplicationDetailsApproveRequestEvent({ required this.leaveId,});
  @override
  List<Object?> get props => [leaveId];
}

class AdminLeaveApplicationDetailsRejectRequestEvent extends AdminLeaveApplicationDetailsEvents {
  final String leaveId;
  AdminLeaveApplicationDetailsRejectRequestEvent({ required this.leaveId,});
  @override
  List<Object?> get props => [leaveId];
}


class AdminLeaveApplicationReasonChangedEvent extends AdminLeaveApplicationDetailsEvents {
   final String adminReply;
   AdminLeaveApplicationReasonChangedEvent(this.adminReply);
  @override
  List<Object?> get props => [adminReply];
}