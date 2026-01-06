import 'package:equatable/equatable.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/model/leave_count.dart';

class UserLeaveCountState extends Equatable {
  final Status status;
  final LeaveCounts usedLeavesCounts;
  final String? error;

  const UserLeaveCountState({
    this.status = Status.initial,
    this.usedLeavesCounts = const LeaveCounts(),
    this.error,
  });

  UserLeaveCountState copyWith({
    Status? status,
    LeaveCounts? usedLeavesCounts,
    String? error,
    double? leavePercentage,
  }) {
    return UserLeaveCountState(
      status: status ?? this.status,
      usedLeavesCounts: usedLeavesCounts ?? this.usedLeavesCounts,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, usedLeavesCounts, error];
}
