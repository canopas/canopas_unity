import 'package:equatable/equatable.dart';
import '../../../../../data/core/utils/bloc_status.dart';

class AdminLeaveDetailsState extends Equatable {
  final Status actionStatus;
  final Status leaveCountStatus;
  final int paidLeaveCount;
  final double usedLeaves;
  final String? error;
  final String adminReply;

  const AdminLeaveDetailsState({
    this.adminReply = "",
    this.paidLeaveCount = 0,
    this.usedLeaves = 0.0,
    this.error,
    this.actionStatus = Status.initial,
    this.leaveCountStatus = Status.initial,
  });

  AdminLeaveDetailsState copyWith(
      {int? paidLeaveCount,
      double? usedLeaves,
      String? error,
      Status? actionStatus,
      Status? leaveCountStatus,
      String? adminReply}) {
    return AdminLeaveDetailsState(
      adminReply: adminReply ?? this.adminReply,
      error: error,
      paidLeaveCount: paidLeaveCount ?? this.paidLeaveCount,
      usedLeaves: usedLeaves ?? this.usedLeaves,
      actionStatus: actionStatus ?? this.actionStatus,
      leaveCountStatus:
          leaveCountStatus ?? this.leaveCountStatus,
    );
  }

  @override
  List<Object?> get props => [
        error,
        leaveCountStatus,
        actionStatus,
        paidLeaveCount,
        usedLeaves,
        adminReply
      ];
}
