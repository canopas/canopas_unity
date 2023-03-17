import 'package:equatable/equatable.dart';

abstract class AdminLeaveApplicationDetailsEvents extends Equatable {}

class AdminLeaveApplicationFetchLeaveCountEvent
    extends AdminLeaveApplicationDetailsEvents {
  final String employeeId;

  AdminLeaveApplicationFetchLeaveCountEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class AdminLeaveApplicationReasonChangedEvent
    extends AdminLeaveApplicationDetailsEvents {
  final String adminReply;

  AdminLeaveApplicationReasonChangedEvent(this.adminReply);

  @override
  List<Object?> get props => [adminReply];
}

enum AdminLeaveResponse { reject, approve }

class AdminLeaveResponseEvent extends AdminLeaveApplicationDetailsEvents {
  final AdminLeaveResponse response;
  final String leaveId;

  AdminLeaveResponseEvent({required this.response, required this.leaveId});

  @override
  List<Object?> get props => [response, leaveId];
}
