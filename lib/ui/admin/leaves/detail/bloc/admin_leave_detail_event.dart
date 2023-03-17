import 'package:equatable/equatable.dart';

abstract class LeaveApplicationDetailEvent extends Equatable {}

class FetchLeaveApplicationDetailEvent extends LeaveApplicationDetailEvent {
  final String employeeId;

  FetchLeaveApplicationDetailEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class DeleteLeaveApplicationEvent extends LeaveApplicationDetailEvent {
  final String leaveId;

  DeleteLeaveApplicationEvent(this.leaveId);

  @override
  List<Object?> get props => [leaveId];
}
