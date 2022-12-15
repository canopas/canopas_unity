import 'package:equatable/equatable.dart';

enum EmployeeLeaveDetailsStatus{initial,success,failure,loading}
enum EmployeeLeaveDetailsLeaveCountStatus{initial,success,failure,loading}

class EmployeeLeaveDetailsState extends Equatable{
  final EmployeeLeaveDetailsStatus leaveDetailsStatus;
  final EmployeeLeaveDetailsLeaveCountStatus leaveDetailsLeaveCountStatus;
  final int paidLeaveCount;
  final double remainingLeaveCount;
  final String? error;

  const EmployeeLeaveDetailsState({
    this.paidLeaveCount = 0,
    this.remainingLeaveCount =0.0,
    this.error,
    this.leaveDetailsStatus = EmployeeLeaveDetailsStatus.initial,
    this.leaveDetailsLeaveCountStatus = EmployeeLeaveDetailsLeaveCountStatus.initial,
  });

  copyWith({int? paidLeaveCount,double? remainingLeaveCount, String? error, EmployeeLeaveDetailsStatus? leaveDetailsStatus, EmployeeLeaveDetailsLeaveCountStatus? leaveDetailsLeaveCountStatus}){
    return EmployeeLeaveDetailsState(
      error: error,
      paidLeaveCount: paidLeaveCount ?? this.paidLeaveCount,
      remainingLeaveCount: remainingLeaveCount ?? this.remainingLeaveCount,
      leaveDetailsStatus: leaveDetailsStatus ?? this.leaveDetailsStatus,
      leaveDetailsLeaveCountStatus: leaveDetailsLeaveCountStatus ?? this.leaveDetailsLeaveCountStatus,
    );
  }

  bool get isFailure => error != null  && (leaveDetailsStatus == EmployeeLeaveDetailsStatus.failure || leaveDetailsLeaveCountStatus == EmployeeLeaveDetailsLeaveCountStatus.failure);

  @override
  List<Object?> get props => [error,leaveDetailsLeaveCountStatus,leaveDetailsStatus,paidLeaveCount,remainingLeaveCount];
}
