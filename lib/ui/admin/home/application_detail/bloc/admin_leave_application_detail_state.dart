import 'package:equatable/equatable.dart';

enum AdminLeaveResponseStatus {
  initial,
  success,
  loading,
}

enum AdminLeaveCountStatus { initial, success, failure, loading }

class AdminLeaveApplicationDetailsState extends Equatable {
  final AdminLeaveResponseStatus adminLeaveResponseStatus;
  final AdminLeaveCountStatus adminLeaveCountStatus;
  final int paidLeaveCount;
  final double usedLeaves;
  final String? error;
  final String adminReply;

  const AdminLeaveApplicationDetailsState({
    this.adminReply = "",
    this.paidLeaveCount = 0,
    this.usedLeaves = 0.0,
    this.error,
    this.adminLeaveResponseStatus = AdminLeaveResponseStatus.initial,
    this.adminLeaveCountStatus = AdminLeaveCountStatus.initial,
  });

  AdminLeaveApplicationDetailsState copyWith(
      {int? paidLeaveCount,
      double? usedLeaves,
      String? error,
      AdminLeaveResponseStatus? leaveDetailsStatus,
      AdminLeaveCountStatus? adminLeaveCountStatus,
      String? adminReply}) {
    return AdminLeaveApplicationDetailsState(
      adminReply: adminReply ?? this.adminReply,
      error: error,
      paidLeaveCount: paidLeaveCount ?? this.paidLeaveCount,
      usedLeaves: usedLeaves ?? this.usedLeaves,
      adminLeaveResponseStatus:
          leaveDetailsStatus ?? this.adminLeaveResponseStatus,
      adminLeaveCountStatus:
          adminLeaveCountStatus ?? this.adminLeaveCountStatus,
    );
  }

  @override
  List<Object?> get props => [
        error,
        adminLeaveCountStatus,
        adminLeaveResponseStatus,
        paidLeaveCount,
        usedLeaves,
        adminReply
      ];
}
