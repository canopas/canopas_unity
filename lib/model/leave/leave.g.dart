// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leave _$LeaveFromJson(Map<String, dynamic> json) => Leave(
      id: json['id'] as int,
      employeeId: json['employee_id'] as int,
      startDate: json['start_date'] as int,
      endDate: json['end_date'] as int,
      totalLeaves: (json['total_leaves'] as num).toDouble(),
      reason: json['reason'] as String,
      emergencyContactPerson: json['emergency_contact_person'] as int,
      status: json['status'] as int,
    );

Map<String, dynamic> _$LeaveToJson(Leave instance) => <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'total_leaves': instance.totalLeaves,
      'reason': instance.reason,
      'emergency_contact_person': instance.emergencyContactPerson,
      'status': instance.status,
    };
