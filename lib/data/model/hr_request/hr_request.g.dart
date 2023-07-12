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
      status: $enumDecodeNullable(_$HrRequestStatusEnumMap, json['status']) ??
          HrRequestStatus.pending,
    );

Map<String, dynamic> _$HrRequestToJson(HrRequest instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'type': _$HrRequestTypeEnumMap[instance.type]!,
      'description': instance.description,
      'status': _$HrRequestStatusEnumMap[instance.status]!,
    };

const _$HrRequestTypeEnumMap = {
  HrRequestType.employeeRelations: 1,
  HrRequestType.training: 2,
  HrRequestType.payroll: 3,
  HrRequestType.timeAndAttendance: 4,
  HrRequestType.hrBenefits: 5,
  HrRequestType.technicalIssue: 6,
  HrRequestType.other: 7,
};

const _$HrRequestStatusEnumMap = {
  HrRequestStatus.pending: 1,
  HrRequestStatus.done: 2,
};
