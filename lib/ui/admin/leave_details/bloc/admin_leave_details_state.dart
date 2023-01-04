import 'package:equatable/equatable.dart';

enum AdminLeaveDetailsStatus{initial,success,failure,approveLoading,rejectLoading,}
enum AdminLeaveDetailsLeaveCountStatus{initial,success,failure,loading}

class AdminLeaveDetailsState extends Equatable{
  final AdminLeaveDetailsStatus leaveDetailsStatus;
  final AdminLeaveDetailsLeaveCountStatus leaveDetailsLeaveCountStatus;
  final int paidLeaveCount;
  final double remainingLeaveCount;
  final String? error;
  final String adminReply;

  const AdminLeaveDetailsState({
    this.adminReply = "",
    this.paidLeaveCount = 0,
    this.remainingLeaveCount =0.0,
    this.error,
    this.leaveDetailsStatus = AdminLeaveDetailsStatus.initial,
    this.leaveDetailsLeaveCountStatus = AdminLeaveDetailsLeaveCountStatus.initial,
  });

  AdminLeaveDetailsState copyWith({int? paidLeaveCount,double? remainingLeaveCount, String? error, AdminLeaveDetailsStatus? leaveDetailsStatus, AdminLeaveDetailsLeaveCountStatus? leaveDetailsLeaveCountStatus, String? adminReply}){
    return AdminLeaveDetailsState(
      adminReply: adminReply ?? this.adminReply,
      error: error,
      paidLeaveCount: paidLeaveCount ?? this.paidLeaveCount,
      remainingLeaveCount: remainingLeaveCount ?? this.remainingLeaveCount,
      leaveDetailsStatus: leaveDetailsStatus ?? this.leaveDetailsStatus,
      leaveDetailsLeaveCountStatus: leaveDetailsLeaveCountStatus ?? this.leaveDetailsLeaveCountStatus,
    );
  }

  bool get isFailure => error != null  && (leaveDetailsStatus == AdminLeaveDetailsStatus.failure || leaveDetailsLeaveCountStatus == AdminLeaveDetailsLeaveCountStatus.failure);

  @override
  List<Object?> get props => [error,leaveDetailsLeaveCountStatus,leaveDetailsStatus,paidLeaveCount,remainingLeaveCount,adminReply];
}
