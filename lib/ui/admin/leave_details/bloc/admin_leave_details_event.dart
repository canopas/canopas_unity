import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class AdminLeaveDetailsEvents extends Equatable {}

class AdminLeaveDetailsInitialLoadEvents extends AdminLeaveDetailsEvents{
  final LeaveApplication leaveApplication;
  AdminLeaveDetailsInitialLoadEvents({required this.leaveApplication});
  @override
  List<Object?> get props => [leaveApplication];
}

class AdminLeaveDetailsApproveRequestEvent extends AdminLeaveDetailsEvents {
  final String leaveId;
  AdminLeaveDetailsApproveRequestEvent({ required this.leaveId,});
  @override
  List<Object?> get props => [leaveId];
}

class AdminLeaveDetailsRejectRequestEvent extends AdminLeaveDetailsEvents {
  final String leaveId;
  AdminLeaveDetailsRejectRequestEvent({ required this.leaveId,});
  @override
  List<Object?> get props => [leaveId];
}

class AdminLeaveDetailsOnUserContentTapEvent extends AdminLeaveDetailsEvents {
  final String id;
  AdminLeaveDetailsOnUserContentTapEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class AdminLeaveDetailsChangeAdminReplyValue extends AdminLeaveDetailsEvents {
   final String adminReply;
   AdminLeaveDetailsChangeAdminReplyValue(this.adminReply);
  @override
  List<Object?> get props => [adminReply];
}