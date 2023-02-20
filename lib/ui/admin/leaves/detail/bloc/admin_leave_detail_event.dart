import 'package:equatable/equatable.dart';

import '../../../../../model/leave_application.dart';

abstract class LeaveApplicationDetailEvent extends Equatable {}

class FetchLeaveApplicationDetailEvent extends LeaveApplicationDetailEvent {
  final LeaveApplication leaveApplication;
  FetchLeaveApplicationDetailEvent({required this.leaveApplication});
  @override
  List<Object?> get props => [leaveApplication];
}

class DeleteLeaveApplicationEvent extends LeaveApplicationDetailEvent {
  final String leaveId;
  DeleteLeaveApplicationEvent(this.leaveId);
  @override
  List<Object?> get props => [leaveId];
}
