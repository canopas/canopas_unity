import 'package:equatable/equatable.dart';

import '../../../../../data/core/utils/bloc_status.dart';


class AdminLeaveApplicationDetailsState extends Equatable {
  final Status status;
  final Status adminLeaveCountStatus;
  final int paidLeaveCount;
  final double usedLeaves;
  final String? error;
  final String adminReply;

  const AdminLeaveApplicationDetailsState({
    this.adminReply = "",
    this.paidLeaveCount = 0,
    this.usedLeaves = 0.0,
    this.error,
    this.status = Status.initial,
    this.adminLeaveCountStatus = Status.initial,
  });

  AdminLeaveApplicationDetailsState copyWith(
      {int? paidLeaveCount,
      double? usedLeaves,
      String? error,
      Status? status,
      Status? adminLeaveCountStatus,
      String? adminReply}) {
    return AdminLeaveApplicationDetailsState(
      adminReply: adminReply ?? this.adminReply,
      error: error,
      paidLeaveCount: paidLeaveCount ?? this.paidLeaveCount,
      usedLeaves: usedLeaves ?? this.usedLeaves,
      status: status ?? this.status,
      adminLeaveCountStatus:
          adminLeaveCountStatus ?? this.adminLeaveCountStatus,
    );
  }

  @override
  List<Object?> get props =>
      [
        error,
        adminLeaveCountStatus,
        status,
        paidLeaveCount,
        usedLeaves,
        adminReply
      ];
}
