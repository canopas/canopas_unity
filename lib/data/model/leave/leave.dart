import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave.g.dart';

const int pendingLeaveStatus = 1;
const int approveLeaveStatus = 2;
const int rejectLeaveStatus = 3;

@JsonSerializable()
class Leave extends Equatable {
  @JsonKey(name: 'leave_id')
  final String leaveId;
  final String uid;
  @JsonKey(name: 'leave_type')
  final int leaveType;
  @JsonKey(name: 'start_date')
  final int startDate;
  @JsonKey(name: 'end_date')
  final int endDate;
  @JsonKey(name: 'total_leaves')
  final double totalLeaves;
  final String reason;
  @JsonKey(name: 'leave_status')
  final int leaveStatus;
  @JsonKey(name: 'rejection_reason')
  final String? rejectionReason;
  @JsonKey(name: 'applied_on')
  final int appliedOn;
  @JsonKey(name: 'per_day_duration')
  final List<int> perDayDuration;

  const Leave(
      {required this.leaveId,
      required this.uid,
      required this.leaveType,
      required this.startDate,
      required this.endDate,
      required this.totalLeaves,
      required this.reason,
      required this.leaveStatus,
      required this.appliedOn,
      required this.perDayDuration,
      this.rejectionReason});

  factory Leave.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return Leave.fromJson(data!);
  }

  factory Leave.fromJson(Map<String,dynamic> map)=>_$LeaveFromJson(map);

  Map<String, dynamic> toFireStore(Leave instance) => _$LeaveToJson(instance);

  @override
  List<Object?> get props => [
        leaveId,
        uid,
        leaveType,
        startDate,
        endDate,
        totalLeaves,
        reason,
        leaveStatus,
        appliedOn,
        rejectionReason
      ];
}
