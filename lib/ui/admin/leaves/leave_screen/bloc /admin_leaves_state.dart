import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave_application.dart';

class AdminLeavesState extends Equatable {
  final Status status;
  final String? error;
  final List<LeaveApplication> upcomingLeaves;
  final List<LeaveApplication> recentLeaves;

  const AdminLeavesState({
    this.status = Status.initial,
    this.error,
    this.recentLeaves = const [],
    this.upcomingLeaves = const [],
  });

  copyWith({
    Status? status,
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
