import 'package:equatable/equatable.dart';
import '../../../../../../model/leave_count.dart';

enum LeaveRequestStatus{initial,loading,failure,success}
enum LeaveRequestLeaveCountStatus{initial,loading,success,failure}

class LeaveRequestViewState extends Equatable {
  final LeaveRequestStatus leaveRequestStatus;
  final LeaveRequestLeaveCountStatus leaveCountStatus;
  final int leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final Map<DateTime, int> selectedDates;
  final double totalLeaveDays;
  final String reason;
  final bool showTextFieldError;
  final LeaveCounts leaveCounts;
  final String? error;

  const LeaveRequestViewState({
    this.leaveRequestStatus = LeaveRequestStatus.initial,
    this.error,
    this.leaveCountStatus = LeaveRequestLeaveCountStatus.initial,
    this.leaveCounts = const LeaveCounts(),
    this.showTextFieldError = false,
    this.leaveType = 0,
    required this.startDate,
    required this.endDate,
    required this.selectedDates,
    this.totalLeaveDays = 1,
    this.reason = "",
  });

  copyWith({
    LeaveRequestStatus? leaveRequestStatus,
    LeaveRequestLeaveCountStatus? leaveCountStatus,
    LeaveCounts? leaveCounts,
    bool? showTextFieldError,
    int? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    Map<DateTime, int>? selectedDates,
    double? totalLeaveDays,
    String? reason,
    String? error,
  }) {
    return LeaveRequestViewState(
        leaveRequestStatus: leaveRequestStatus ?? this.leaveRequestStatus,
        leaveCountStatus: leaveCountStatus ?? this.leaveCountStatus,
        error: error,
        leaveCounts: leaveCounts ?? this.leaveCounts,
        showTextFieldError: showTextFieldError ?? this.showTextFieldError,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        leaveType: leaveType ?? this.leaveType,
        reason: reason ?? this.reason,
        selectedDates: selectedDates ?? this.selectedDates,
        totalLeaveDays: totalLeaveDays ?? this.totalLeaveDays);
  }

  bool get isFailure => error != null && (leaveCountStatus == LeaveRequestLeaveCountStatus.failure || leaveRequestStatus == LeaveRequestStatus.failure);

  @override
  List<Object?> get props => [
        leaveRequestStatus,
        leaveCountStatus,
        error,
        leaveCounts,
        showTextFieldError,
        leaveType,
        startDate,
        selectedDates,
        endDate,
        totalLeaveDays,
        reason
      ];
}
