import 'package:equatable/equatable.dart';
import '../../../../../data/model/leave/leave.dart';

abstract class AdminLeaveDetailsEvents extends Equatable {}

class AdminLeaveDetailsFetchLeaveCountEvent extends AdminLeaveDetailsEvents {
  final String employeeId;

  AdminLeaveDetailsFetchLeaveCountEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class ReasonChangedEvent extends AdminLeaveDetailsEvents {
  final String adminReply;

  ReasonChangedEvent(this.adminReply);

  @override
  List<Object?> get props => [adminReply];
}

class LeaveResponseEvent extends AdminLeaveDetailsEvents {
  final LeaveStatus responseStatus;
  final String leaveId;

  LeaveResponseEvent({required this.responseStatus, required this.leaveId});

  @override
  List<Object?> get props => [responseStatus, leaveId];
}
