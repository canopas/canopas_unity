// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormResponse _$FormResponseFromJson(Map<String, dynamic> json) => FormResponse(
      submittedAt:
          const DateTimeConverter().fromJson(json['submitted_at'] as int),
      uid: json['uid'] as String,
      formId: json['form_id'] as String,
      response: (json['response'] as List<dynamic>)
          .map((e) => FormFieldResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FormResponseToJson(FormResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'form_id': instance.formId,
      'submitted_at': const DateTimeConverter().toJson(instance.submittedAt),
      'response': instance.response,
    };
