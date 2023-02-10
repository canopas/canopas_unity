import 'package:equatable/equatable.dart';

enum LeaveDetailsStatus{initial,success,failure,loading}
enum LeaveDetailsLeaveCountStatus{initial,success,failure,loading}

class LeaveDetailsState extends Equatable{
  final LeaveDetailsStatus leaveDetailsStatus;
  final LeaveDetailsLeaveCountStatus leaveDetailsLeaveCountStatus;
  final int paidLeaveCount;
  final double remainingLeaveCount;
  final String? error;

  const LeaveDetailsState({
    this.paidLeaveCount = 0,
    this.remainingLeaveCount =0.0,
    this.error,
    this.leaveDetailsStatus = LeaveDetailsStatus.initial,
    this.leaveDetailsLeaveCountStatus = LeaveDetailsLeaveCountStatus.initial,
  });

  copyWith({int? paidLeaveCount,double? remainingLeaveCount, String? error, LeaveDetailsStatus? leaveDetailsStatus, LeaveDetailsLeaveCountStatus? leaveDetailsLeaveCountStatus}){
    return LeaveDetailsState(
      error: error,
      paidLeaveCount: paidLeaveCount ?? this.paidLeaveCount,
      remainingLeaveCount: remainingLeaveCount ?? this.remainingLeaveCount,
      leaveDetailsStatus: leaveDetailsStatus ?? this.leaveDetailsStatus,
      leaveDetailsLeaveCountStatus: leaveDetailsLeaveCountStatus ?? this.leaveDetailsLeaveCountStatus,
    );
  }

  bool get isFailure => error != null  && (leaveDetailsStatus == LeaveDetailsStatus.failure || leaveDetailsLeaveCountStatus == LeaveDetailsLeaveCountStatus.failure);

  @override
  List<Object?> get props => [error,leaveDetailsLeaveCountStatus,leaveDetailsStatus,paidLeaveCount,remainingLeaveCount];
}
