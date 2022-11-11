// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leave _$LeaveFromJson(Map<String, dynamic> json) => Leave(
      leaveId: json['leave_id'] as String,
      uid: json['uid'] as String,
      leaveType: json['leave_type'] as int,
      startDate: json['start_date'] as int,
      endDate: json['end_date'] as int,
      totalLeaves: (json['total_leaves'] as num).toDouble(),
      reason: json['reason'] as String,
      leaveStatus: json['leave_status'] as int,
      appliedOn: json['applied_on'] as int,
      perDayDuration: (json['per_day_duration'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      rejectionReason: json['rejection_reason'] as String?,
    );

Map<String, dynamic> _$LeaveToJson(Leave instance) => <String, dynamic>{
      'leave_id': instance.leaveId,
      'uid': instance.uid,
      'leave_type': instance.leaveType,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'total_leaves': instance.totalLeaves,
      'reason': instance.reason,
      'leave_status': instance.leaveStatus,
      'rejection_reason': instance.rejectionReason,
      'applied_on': instance.appliedOn,
      'per_day_duration': instance.perDayDuration,
    };
