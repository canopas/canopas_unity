import 'package:equatable/equatable.dart';

enum AdminLeaveApplicationDetailsStatus{initial,success,failure,approveLoading,rejectLoading,}
enum AdminLeaveApplicationDetailsLeaveCountStatus{initial,success,failure,loading}

class AdminLeaveApplicationDetailsState extends Equatable{
  final AdminLeaveApplicationDetailsStatus leaveDetailsStatus;
  final AdminLeaveApplicationDetailsLeaveCountStatus leaveDetailsLeaveCountStatus;
  final int paidLeaveCount;
  final double remainingLeaveCount;
  final String? error;
  final String adminReply;

  const AdminLeaveApplicationDetailsState({
    this.adminReply = "",
    this.paidLeaveCount = 0,
    this.remainingLeaveCount =0.0,
    this.error,
    this.leaveDetailsStatus = AdminLeaveApplicationDetailsStatus.initial,
    this.leaveDetailsLeaveCountStatus = AdminLeaveApplicationDetailsLeaveCountStatus.initial,
  });

  copyWith({int? paidLeaveCount,double? remainingLeaveCount, String? error, AdminLeaveApplicationDetailsStatus? leaveDetailsStatus, AdminLeaveApplicationDetailsLeaveCountStatus? leaveDetailsLeaveCountStatus, String? adminReply}){
    return AdminLeaveApplicationDetailsState(
      adminReply: adminReply ?? this.adminReply,
      error: error,
      paidLeaveCount: paidLeaveCount ?? this.paidLeaveCount,
      remainingLeaveCount: remainingLeaveCount ?? this.remainingLeaveCount,
      leaveDetailsStatus: leaveDetailsStatus ?? this.leaveDetailsStatus,
      leaveDetailsLeaveCountStatus: leaveDetailsLeaveCountStatus ?? this.leaveDetailsLeaveCountStatus,
    );
  }

  bool get isFailure => error != null  && (leaveDetailsStatus == AdminLeaveApplicationDetailsStatus.failure || leaveDetailsLeaveCountStatus == AdminLeaveApplicationDetailsLeaveCountStatus.failure);

  @override
  List<Object?> get props => [error,leaveDetailsLeaveCountStatus,leaveDetailsStatus,paidLeaveCount,remainingLeaveCount,adminReply];
}
