// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldResponse _$FormFieldResponseFromJson(Map<String, dynamic> json) =>
    FormFieldResponse(
      fieldId: json['field_id'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$FormFieldResponseToJson(FormFieldResponse instance) =>
    <String, dynamic>{
      'field_id': instance.fieldId,
      'answer': instance.answer,
    };
