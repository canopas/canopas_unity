import 'package:equatable/equatable.dart';
import '../../../../../data/core/utils/bloc_status.dart';

class AdminLeaveDetailsState extends Equatable {
  final Status actionStatus;
  final Status leaveCountStatus;
  final double usedLeaves;
  final String? error;
  final String adminReply;

  const AdminLeaveDetailsState({
    this.adminReply = "",
    this.usedLeaves = 0.0,
    this.error,
    this.actionStatus = Status.initial,
    this.leaveCountStatus = Status.initial,
  });

  AdminLeaveDetailsState copyWith(
      {double? usedLeaves,
      String? error,
      Status? actionStatus,
      Status? leaveCountStatus,
      String? adminReply}) {
    return AdminLeaveDetailsState(
      adminReply: adminReply ?? this.adminReply,
      error: error,
      usedLeaves: usedLeaves ?? this.usedLeaves,
      actionStatus: actionStatus ?? this.actionStatus,
      leaveCountStatus: leaveCountStatus ?? this.leaveCountStatus,
    );
  }

  @override
  List<Object?> get props =>
      [error, leaveCountStatus, actionStatus, usedLeaves, adminReply];
}
