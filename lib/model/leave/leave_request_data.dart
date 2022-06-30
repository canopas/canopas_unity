import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_request_data.g.dart';

@JsonSerializable()
class LeaveRequestData {
  String uid;
  @JsonKey(name: 'leave_type')
  int? leaveType;
  @JsonKey(name: 'start_date')
  int startDate;
  @JsonKey(name: 'end_date')
  int endDate;
  @JsonKey(name: 'total_leaves')
  double totalLeaves;
  String reason;
  @JsonKey(name: 'emergency_contact_person')
  int emergencyContactPerson;

  LeaveRequestData(
      {required this.uid,
      this.leaveType,
      required this.startDate,
      required this.endDate,
      required this.totalLeaves,
      required this.reason,
      required this.emergencyContactPerson});

  factory LeaveRequestData.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return LeaveRequestData(
      uid: data?['uid'] as String,
      leaveType: data?['leave_type'] as int?,
      startDate: data?['start_date'] as int,
      endDate: data?['end_date'] as int,
      totalLeaves: (data?['total_leaves'] as num).toDouble(),
      reason: data?['reason'] as String,
      emergencyContactPerson: data?['emergency_contact_person'] as int,
    );
  }

  Map<String, dynamic> toFireStore(LeaveRequestData instance) =>
      <String, dynamic>{
        'uid': instance.uid,
        'leave_type': instance.leaveType,
        'start_date': instance.startDate,
        'end_date': instance.endDate,
        'total_leaves': instance.totalLeaves,
        'reason': instance.reason,
        'emergency_contact_person': instance.emergencyContactPerson,
      };
}
