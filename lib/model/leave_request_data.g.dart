// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestData _$LeaveRequestDataFromJson(Map<String, dynamic> json) =>
    LeaveRequestData(
      startDate: json['start_date'] as int,
      endDate: json['end_date'] as int,
      totalLeaves: (json['total_leaves'] as num).toDouble(),
      reason: json['reason'] as String,
      emergencyContactPerson: json['emergency_contact_person'] as int,
    );

Map<String, dynamic> _$LeaveRequestDataToJson(LeaveRequestData instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'total_leaves': instance.totalLeaves,
      'reason': instance.reason,
      'emergency_contact_person': instance.emergencyContactPerson,
    };
