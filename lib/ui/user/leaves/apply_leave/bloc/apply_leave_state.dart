import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/leave/leave.dart';

import '../../../../../data/core/utils/bloc_status.dart';

class ApplyLeaveState extends Equatable {
  final Status leaveRequestStatus;
  final int leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final Map<DateTime, LeaveDayDuration> selectedDates;
  final double totalLeaveDays;
  final String reason;
  final bool showTextFieldError;
  final String? error;

  const ApplyLeaveState({
    this.leaveRequestStatus = Status.initial,
    this.error,
    this.showTextFieldError = false,
    this.leaveType = 0,
    required this.startDate,
    required this.endDate,
    required this.selectedDates,
    this.totalLeaveDays = 1,
    this.reason = "",
  });

  ApplyLeaveState copyWith({
    Status? leaveRequestStatus,
    bool? showTextFieldError,
    int? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    Map<DateTime, LeaveDayDuration>? selectedDates,
    double? totalLeaveDays,
    String? reason,
    String? error,
  }) {
    return ApplyLeaveState(
        leaveRequestStatus: leaveRequestStatus ?? this.leaveRequestStatus,
        error: error,
        showTextFieldError: showTextFieldError ?? this.showTextFieldError,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        leaveType: leaveType ?? this.leaveType,
        reason: reason ?? this.reason,
        selectedDates: selectedDates ?? this.selectedDates,
        totalLeaveDays: totalLeaveDays ?? this.totalLeaveDays);
  }

  bool get isFailure => error != null && leaveRequestStatus == Status.error;

  @override
  List<Object?> get props => [
        leaveRequestStatus,
        error,
        showTextFieldError,
        leaveType,
        startDate,
        selectedDates,
        endDate,
        totalLeaveDays,
        reason
      ];
}
