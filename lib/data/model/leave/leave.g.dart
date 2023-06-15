// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leave _$LeaveFromJson(Map<String, dynamic> json) => Leave(
      leaveId: json['leave_id'] as String,
      uid: json['uid'] as String,
      type: $enumDecode(_$LeaveTypeEnumMap, json['type']),
      startDate: const DateTimeConverter().fromJson(json['start_date'] as int),
      endDate: const DateTimeConverter().fromJson(json['end_date'] as int),
      total: (json['total'] as num).toDouble(),
      reason: json['reason'] as String,
      status: $enumDecode(_$LeaveStatusEnumMap, json['status']),
      appliedOn: const DateTimeConverter().fromJson(json['applied_on'] as int),
      perDayDuration: (json['per_day_duration'] as List<dynamic>)
          .map((e) => $enumDecode(_$LeaveDayDurationEnumMap, e))
          .toList(),
      response: json['response'] as String?,
    );

Map<String, dynamic> _$LeaveToJson(Leave instance) {
  final val = <String, dynamic>{
    'leave_id': instance.leaveId,
    'uid': instance.uid,
    'type': _$LeaveTypeEnumMap[instance.type]!,
    'start_date': const DateTimeConverter().toJson(instance.startDate),
    'end_date': const DateTimeConverter().toJson(instance.endDate),
    'total': instance.total,
    'reason': instance.reason,
    'status': _$LeaveStatusEnumMap[instance.status]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('response', instance.response);
  val['applied_on'] = const DateTimeConverter().toJson(instance.appliedOn);
  val['per_day_duration'] = instance.perDayDuration
      .map((e) => _$LeaveDayDurationEnumMap[e]!)
      .toList();
  return val;
}

const _$LeaveTypeEnumMap = {
  LeaveType.casualLeave: 0,
  LeaveType.sickLeave: 1,
  LeaveType.annualLeave: 2,
  LeaveType.paternityLeave: 3,
  LeaveType.maternityLeave: 4,
  LeaveType.marriageLeave: 5,
  LeaveType.bereavementLeave: 6,
};

const _$LeaveStatusEnumMap = {
  LeaveStatus.pending: 1,
  LeaveStatus.approved: 2,
  LeaveStatus.rejected: 3,
  LeaveStatus.cancelled: 4,
};

const _$LeaveDayDurationEnumMap = {
  LeaveDayDuration.noLeave: 0,
  LeaveDayDuration.firstHalfLeave: 1,
  LeaveDayDuration.secondHalfLeave: 2,
  LeaveDayDuration.fullLeave: 3,
};
