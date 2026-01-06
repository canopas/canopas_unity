import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/leave_count.dart';
import '../../../../../data/core/utils/bloc_status.dart';

class AdminLeaveDetailsState extends Equatable {
  final Status actionStatus;
  final Status leaveCountStatus;
  final LeaveCounts usedLeavesCount;
  final String? error;
  final String adminReply;

  const AdminLeaveDetailsState({
    this.adminReply = "",
    this.usedLeavesCount = const LeaveCounts(casualLeaves: 0, urgentLeaves: 0),
    this.error,
    this.actionStatus = Status.initial,
    this.leaveCountStatus = Status.initial,
  });

  AdminLeaveDetailsState copyWith({
    LeaveCounts? usedLeavesCount,
    String? error,
    Status? actionStatus,
    Status? leaveCountStatus,
    String? adminReply,
  }) {
    return AdminLeaveDetailsState(
      adminReply: adminReply ?? this.adminReply,
      error: error,
      usedLeavesCount: usedLeavesCount ?? this.usedLeavesCount,
      actionStatus: actionStatus ?? this.actionStatus,
      leaveCountStatus: leaveCountStatus ?? this.leaveCountStatus,
    );
  }

  @override
  List<Object?> get props => [
    error,
    leaveCountStatus,
    actionStatus,
    usedLeavesCount,
    adminReply,
  ];
}
