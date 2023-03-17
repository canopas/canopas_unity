import 'package:equatable/equatable.dart';
import '../../../../../data/model/leave_application.dart';

enum AdminLeavesStatus { initial, loading, failure, success }

class AdminLeavesState extends Equatable {
  final AdminLeavesStatus status;
  final String? error;
  final List<LeaveApplication> upcomingLeaves;
  final List<LeaveApplication> recentLeaves;

  const AdminLeavesState({
    this.status = AdminLeavesStatus.initial,
    this.error,
    this.recentLeaves = const [],
    this.upcomingLeaves = const [],
  });

  copyWith({
    AdminLeavesStatus? status,
    String? error,
    List<LeaveApplication>? upcomingLeaves,
    List<LeaveApplication>? recentLeaves,
  }) =>
      AdminLeavesState(
        recentLeaves: recentLeaves ?? this.recentLeaves,
        upcomingLeaves: upcomingLeaves ?? this.upcomingLeaves,
        status: status ?? this.status,
        error: error,
      );

  @override
  List<Object?> get props => [status, error, upcomingLeaves, recentLeaves];
}
