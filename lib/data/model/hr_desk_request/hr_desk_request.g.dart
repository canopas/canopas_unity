// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_desk_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HrDeskRequest _$HrDeskRequestFromJson(Map<String, dynamic> json) =>
    HrDeskRequest(
      id: json['id'] as String,
      type: $enumDecode(_$HRDeskRequestTypeEnumMap, json['type']),
      requestBy: json['request_by'] as String,
      description: json['description'] as String,
      status:
          $enumDecodeNullable(_$HRDeskRequestStatusEnumMap, json['status']) ??
              HRDeskRequestStatus.pending,
    );

Map<String, dynamic> _$HrDeskRequestToJson(HrDeskRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'request_by': instance.requestBy,
      'type': _$HRDeskRequestTypeEnumMap[instance.type]!,
      'description': instance.description,
      'status': _$HRDeskRequestStatusEnumMap[instance.status]!,
    };

const _$HRDeskRequestTypeEnumMap = {
  HRDeskRequestType.employeeRelations: 1,
  HRDeskRequestType.training: 2,
  HRDeskRequestType.payroll: 3,
  HRDeskRequestType.timeAndAttendance: 4,
  HRDeskRequestType.hrBenefits: 5,
  HRDeskRequestType.technicalIssue: 6,
  HRDeskRequestType.other: 7,
};

const _$HRDeskRequestStatusEnumMap = {
  HRDeskRequestStatus.pending: 1,
  HRDeskRequestStatus.done: 2,
};
