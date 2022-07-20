// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestData _$LeaveRequestDataFromJson(Map<String, dynamic> json) =>
    LeaveRequestData(
      leaveId: json['leaveId'] as String,
      uid: json['uid'] as String,
      leaveType: json['leave_type'] as int?,
      startDate: json['start_date'] as int,
      endDate: json['end_date'] as int,
      totalLeaves: (json['total_leaves'] as num).toDouble(),
      reason: json['reason'] as String,
      emergencyContactPerson: json['emergency_contact_person'] as int,
      leaveStatus: json['leave_status'] as int,
      appliedOn: json['applied_on'] as int,
      rejectionReason: json['rejectionReason'] as String?,
    );

Map<String, dynamic> _$LeaveRequestDataToJson(LeaveRequestData instance) =>
    <String, dynamic>{
      'leaveId': instance.leaveId,
      'uid': instance.uid,
      'leave_type': instance.leaveType,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'total_leaves': instance.totalLeaves,
      'reason': instance.reason,
      'emergency_contact_person': instance.emergencyContactPerson,
      'leave_status': instance.leaveStatus,
      'rejectionReason': instance.rejectionReason,
      'applied_on': instance.appliedOn,
    };
