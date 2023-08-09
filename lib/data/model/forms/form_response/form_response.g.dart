// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormResponse _$FormResponseFromJson(Map<String, dynamic> json) => FormResponse(
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
      'response': instance.response,
    };
