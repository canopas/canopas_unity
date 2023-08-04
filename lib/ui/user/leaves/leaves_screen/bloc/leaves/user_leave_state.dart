import 'package:equatable/equatable.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/model/leave/leave.dart';

class UserLeaveState extends Equatable {
  final Map<DateTime, List<Leave>> leavesMap;
  final String? error;
  final Status status;
  final Status fetchMoreDataStatus;

  const UserLeaveState(
      {this.fetchMoreDataStatus = Status.initial,
      this.leavesMap = const {},
      this.status = Status.initial,
      this.error});

  UserLeaveState copyWith({
    Status? fetchMoreDataStatus,
    Map<DateTime, List<Leave>>? leavesMap,
    String? error,
    Status? status,
  }) =>
      UserLeaveState(
        fetchMoreDataStatus: fetchMoreDataStatus ?? this.fetchMoreDataStatus,
        status: status ?? this.status,
        leavesMap: leavesMap ?? this.leavesMap,
        error: error,
      );

  @override
  List<Object?> get props => [leavesMap, error, status, fetchMoreDataStatus];
}
