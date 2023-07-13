// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HrRequest _$HrRequestFromJson(Map<String, dynamic> json) => HrRequest(
      id: json['id'] as String,
      type: $enumDecode(_$HrRequestTypeEnumMap, json['type']),
      uid: json['uid'] as String,
      description: json['description'] as String,
      requestedAt:
          const DateTimeConverter().fromJson(json['requested_at'] as int),
      response: json['response'] as String?,
      status: $enumDecodeNullable(_$HrRequestStatusEnumMap, json['status']) ??
          HrRequestStatus.pending,
    );

Map<String, dynamic> _$HrRequestToJson(HrRequest instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'uid': instance.uid,
    'requested_at': const DateTimeConverter().toJson(instance.requestedAt),
    'type': _$HrRequestTypeEnumMap[instance.type]!,
    'description': instance.description,
    'status': _$HrRequestStatusEnumMap[instance.status]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('response', instance.response);
  return val;
}

const _$HrRequestTypeEnumMap = {
  HrRequestType.employeeRelations: 0,
  HrRequestType.training: 1,
  HrRequestType.payroll: 2,
  HrRequestType.timeAndAttendance: 3,
  HrRequestType.hrBenefits: 4,
  HrRequestType.technicalIssue: 5,
  HrRequestType.other: 6,
};

const _$HrRequestStatusEnumMap = {
  HrRequestStatus.pending: 0,
  HrRequestStatus.resolved: 1,
  HrRequestStatus.canceled: 2,
};
