import 'package:equatable/equatable.dart';

abstract class UserLeaveDetailEvent extends Equatable {}

class FetchLeaveDetailEvent extends UserLeaveDetailEvent {
  final String leaveId;

  FetchLeaveDetailEvent({required this.leaveId});

  @override
  List<Object?> get props => [leaveId];
}

class CancelLeaveApplicationEvent extends UserLeaveDetailEvent {
  final String leaveId;

  CancelLeaveApplicationEvent({required this.leaveId});

  @override
  List<Object?> get props => [leaveId];
}
