import 'package:equatable/equatable.dart';

import '../../../../model/leave_application.dart';
import '../../../../model/leave_count.dart';

enum EmployeeHomeStatus { initial, loading, success, failure }

class EmployeeHomeState extends Equatable {
  final EmployeeHomeStatus status;
  final LeaveCounts leaveCount;
  final List<LeaveApplication>? absence;
  final String? error;

  const EmployeeHomeState(
      {this.status = EmployeeHomeStatus.initial,
      this.leaveCount=const LeaveCounts(),
      this.absence = const [],
      this.error});

  EmployeeHomeState copyWith(
      {EmployeeHomeStatus? status,
      LeaveCounts? leaveCounts,
      List<LeaveApplication>? absence}) {
    return EmployeeHomeState(
        status: status ?? this.status,
        leaveCount: leaveCounts ?? leaveCount,
        absence: absence ?? this.absence);
  }
  EmployeeHomeState failure({required String error}){
    return EmployeeHomeState(status: EmployeeHomeStatus.failure,error:this.error);
  }

  @override
  List<Object?> get props => [status, leaveCount, absence,error];
}
