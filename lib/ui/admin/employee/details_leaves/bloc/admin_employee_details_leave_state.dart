import 'package:equatable/equatable.dart';
import '../../../../../data/model/leave/leave.dart';

class AdminEmployeeDetailsLeavesState extends Equatable {
  final List<Leave> recentLeaves;
  final List<Leave> upcomingLeaves;
  final List<Leave> pastLeaves;
  final bool loading;
  final String? error;

  const AdminEmployeeDetailsLeavesState({
    this.error,
    this.recentLeaves = const [],
    this.upcomingLeaves = const [],
    this.pastLeaves = const [],
    this.loading = false,
  });

  copyWith({
    List<Leave>? recentLeaves,
    List<Leave>? upcomingLeaves,
    List<Leave>? pastLeaves,
    bool? loading,
    String? error,
  }) =>
      AdminEmployeeDetailsLeavesState(
          error: error,
          recentLeaves: recentLeaves ?? this.recentLeaves,
          upcomingLeaves: upcomingLeaves ?? this.upcomingLeaves,
          pastLeaves: pastLeaves ?? this.pastLeaves,
          loading: loading ?? this.loading);

  @override
  List<Object?> get props => [
        error,
        recentLeaves,
        upcomingLeaves,
        pastLeaves,
        loading,
      ];
}
