import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave.g.dart';

const int pendingLeaveStatus = 1;
const int approveLeaveStatus = 2;
const int rejectLeaveStatus = 3;

@JsonSerializable()
class Leave {
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
  @JsonKey(name: 'emergency_contact_person')
  int? emergencyContactPerson;
  @JsonKey(name: 'leave_status')
  int leaveStatus;
  String? rejectionReason;
  @JsonKey(name: 'applied_on')
  int appliedOn;

  Leave(
      {required this.leaveId,
      required this.uid,
      required this.leaveType,
      required this.startDate,
      required this.endDate,
      required this.totalLeaves,
      required this.reason,
      this.emergencyContactPerson,
      required this.leaveStatus,
      required this.appliedOn,
      this.rejectionReason});

  factory Leave.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return _$LeaveFromJson(data!);
  }

  Map<String, dynamic> toFireStore(Leave instance) => _$LeaveToJson(instance);
}

