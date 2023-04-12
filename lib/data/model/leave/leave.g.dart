// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leave _$LeaveFromJson(Map<String, dynamic> json) => Leave(
      leaveId: json['leave_id'] as String,
      uid: json['uid'] as String,
      type: json['type'] as int,
      startDate: json['start_date'] as int,
      endDate: json['end_date'] as int,
      total: (json['total'] as num).toDouble(),
      reason: json['reason'] as String,
      status: json['status'] as int,
      appliedOn: json['applied_on'] as int,
      perDayDuration: (json['per_day_duration'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      rejectionReason: json['rejection_reason'] as String?,
    );

Map<String, dynamic> _$LeaveToJson(Leave instance) {
  final val = <String, dynamic>{
    'leave_id': instance.leaveId,
    'uid': instance.uid,
    'type': instance.type,
    'start_date': instance.startDate,
    'end_date': instance.endDate,
    'total': instance.total,
    'reason': instance.reason,
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rejection_reason', instance.rejectionReason);
  val['applied_on'] = instance.appliedOn;
  val['per_day_duration'] = instance.perDayDuration;
  return val;
}
