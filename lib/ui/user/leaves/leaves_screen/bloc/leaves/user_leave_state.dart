import 'package:equatable/equatable.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/model/leave/leave.dart';

class UserLeaveState extends Equatable {
  final Map<DateTime, List<Leave>> casualLeaves;
  final Map<DateTime, List<Leave>> urgentLeaves;

  final String? error;
  final Status status;
  final Status fetchMoreDataStatus;

  const UserLeaveState({
    this.fetchMoreDataStatus = Status.initial,
    this.casualLeaves = const {},
    this.urgentLeaves = const {},
    this.status = Status.initial,
    this.error,
  });

  UserLeaveState copyWith({
    Status? fetchMoreDataStatus,
    Map<DateTime, List<Leave>>? casualLeaves,
    Map<DateTime, List<Leave>>? urgentLeaves,
    String? error,
    Status? status,
  }) => UserLeaveState(
    fetchMoreDataStatus: fetchMoreDataStatus ?? this.fetchMoreDataStatus,
    status: status ?? this.status,
    casualLeaves: casualLeaves ?? this.casualLeaves,
    urgentLeaves: urgentLeaves ?? this.urgentLeaves,
    error: error,
  );

  @override
  List<Object?> get props => [
    casualLeaves,
    urgentLeaves,
    error,
    status,
    fetchMoreDataStatus,
  ];
}
