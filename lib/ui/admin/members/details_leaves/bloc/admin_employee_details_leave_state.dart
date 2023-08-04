import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave/leave.dart';

class AdminEmployeeDetailsLeavesState extends Equatable {
  final Map<DateTime, List<Leave>> leavesMap;
  final Status status;
  final String? error;
  final Status fetchMoreDataStatus;

  const AdminEmployeeDetailsLeavesState({
    this.error,
    this.leavesMap = const {},
    this.status = Status.initial,
    this.fetchMoreDataStatus = Status.initial,
  });

  copyWith({
    Map<DateTime, List<Leave>>? leavesMap,
    Status? status,
    Status? fetchMoreDataStatus,
    String? error,
  }) =>
      AdminEmployeeDetailsLeavesState(
        error: error,
        leavesMap: leavesMap ?? this.leavesMap,
        status: status ?? this.status,
        fetchMoreDataStatus: fetchMoreDataStatus ?? this.fetchMoreDataStatus,
      );

  @override
  List<Object?> get props => [error, leavesMap, fetchMoreDataStatus, status];
}
