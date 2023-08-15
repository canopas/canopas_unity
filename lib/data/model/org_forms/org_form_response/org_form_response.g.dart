// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgFormResponse _$OrgFormResponseFromJson(Map<String, dynamic> json) =>
    OrgFormResponse(
      id: json['id'] as String,
      submittedAt:
          const DateTimeConverter().fromJson(json['submitted_at'] as int),
      uid: json['uid'] as String,
      formId: json['form_id'] as String,
      response: (json['response'] as List<dynamic>)
          .map((e) => OrgFormFieldResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrgFormResponseToJson(OrgFormResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'form_id': instance.formId,
      'submitted_at': const DateTimeConverter().toJson(instance.submittedAt),
      'response': instance.response,
    };
