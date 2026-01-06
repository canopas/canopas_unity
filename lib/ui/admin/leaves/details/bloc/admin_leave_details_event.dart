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
  final String name;
  final String leaveId;
  final DateTime startDate;
  final DateTime endDate;
  final String email;

  LeaveResponseEvent({
    required this.leaveId,
    required this.responseStatus,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.email,
  });

  @override
  List<Object?> get props => [
    leaveId,
    responseStatus,
    name,
    startDate,
    endDate,
    email,
  ];
}
