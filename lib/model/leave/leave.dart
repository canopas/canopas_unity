import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave.g.dart';

const int pendingLeaveStatus = 1;
const int approveLeaveStatus = 2;
const int rejectLeaveStatus = 3;

@JsonSerializable()
class Leave {
  @JsonKey(name: 'leave_id')
  String leaveId;
  String uid;
  @JsonKey(name: 'leave_type')
  int leaveType;
  @JsonKey(name: 'start_date')
  int startDate;
  @JsonKey(name: 'end_date')
  int endDate;
  @JsonKey(name: 'total_leaves')
  double totalLeaves;
  String reason;
  @JsonKey(name: 'leave_status')
  int leaveStatus;
  @JsonKey(name: 'rejection_reason')
  String? rejectionReason;
  @JsonKey(name: 'applied_on')
  int appliedOn;
  @JsonKey(name: 'per_day_duration')
  List<int> perDayDuration;

  Leave(
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
    return _$LeaveFromJson(data!);
  }

  Map<String, dynamic> toFireStore(Leave instance) => _$LeaveToJson(instance);
}

