import 'package:equatable/equatable.dart';

import '../../../../model/leave_application.dart';

enum AdminHomeStatus { initial, loading, success, failure }

class AdminHomeState extends Equatable {
  final AdminHomeStatus status;
  final Map<DateTime, List<LeaveApplication>> leaveAppMap;
  final String? error;

  const AdminHomeState(
      {this.status = AdminHomeStatus.initial,
      this.leaveAppMap = const {},
      this.error});

  AdminHomeState copyWith({
    AdminHomeStatus? status,
    Map<DateTime, List<LeaveApplication>>? leaveAppMap,
  }) {
    return AdminHomeState(
      status: status ?? this.status,
      leaveAppMap: leaveAppMap ?? this.leaveAppMap,
    );
  }

  AdminHomeState failureState(
      {AdminHomeStatus? status, required String failureMessage}) {
    return AdminHomeState(status: AdminHomeStatus.failure, error: failureMessage);
  }

  @override
  List<Object?> get props => [status, leaveAppMap, error];
}
