import 'package:equatable/equatable.dart';
import 'package:projectunity/model/leave_application.dart';

enum AdminLeavesStatus { initial, loading, failure, success }

class AdminLeavesState extends Equatable {
  final AdminLeavesStatus status;
  final String? error;
  final List<LeaveApplication> upcomingLeaves;
  final List<LeaveApplication> recentLeaves;
  final bool fetchMoreRecentLeaves;

  const AdminLeavesState({
    this.fetchMoreRecentLeaves = false,
    this.status = AdminLeavesStatus.initial,
    this.error,
    this.recentLeaves = const [],
    this.upcomingLeaves = const [],
  });

  copyWith({
    bool? fetchMoreRecentLeaves,
    AdminLeavesStatus? status,
    String? error,
    List<LeaveApplication>? upcomingLeaves,
    List<LeaveApplication>? recentLeaves,
  }) =>
      AdminLeavesState(
        fetchMoreRecentLeaves: fetchMoreRecentLeaves ?? this.fetchMoreRecentLeaves,
        recentLeaves: recentLeaves ?? this.recentLeaves,
        upcomingLeaves: upcomingLeaves ?? this.upcomingLeaves,
        status: status ?? this.status,
        error: error,
      );

  @override
  List<Object?> get props => [status, error, upcomingLeaves, recentLeaves,fetchMoreRecentLeaves];
}
