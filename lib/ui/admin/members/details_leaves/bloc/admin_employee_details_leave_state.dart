import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave/leave.dart';

class AdminEmployeeDetailsLeavesState extends Equatable {
  final List<Leave> recentLeaves;
  final List<Leave> upcomingLeaves;
  final List<Leave> pastLeaves;
  final Status status;
  final String? error;

  const AdminEmployeeDetailsLeavesState({
    this.error,
    this.recentLeaves = const [],
    this.upcomingLeaves = const [],
    this.pastLeaves = const [],
    this.status = Status.initial,
  });

  copyWith({
    List<Leave>? recentLeaves,
    List<Leave>? upcomingLeaves,
    List<Leave>? pastLeaves,
    bool? loading,
    Status? status,
    String? error,
  }) =>
      AdminEmployeeDetailsLeavesState(
        error: error,
        recentLeaves: recentLeaves ?? this.recentLeaves,
        upcomingLeaves: upcomingLeaves ?? this.upcomingLeaves,
        pastLeaves: pastLeaves ?? this.pastLeaves,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        error,
        recentLeaves,
        upcomingLeaves,
        pastLeaves,
    status];
}
