// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgFormField _$OrgFormFieldFromJson(Map<String, dynamic> json) => OrgFormField(
      id: json['id'] as String,
      index: json['index'] as int,
      question: json['question'] as String,
      answerType:
          $enumDecodeNullable(_$FieldInputTypeEnumMap, json['input_type']) ??
              FormFieldAnswerType.text,
      type: $enumDecodeNullable(_$FieldTypeEnumMap, json['type']) ??
          FormFieldType.text,
      isRequired: json['is_required'] as bool? ?? false,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OrgFormFieldToJson(OrgFormField instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'index': instance.index,
    'question': instance.question,
    'type': _$FieldTypeEnumMap[instance.type]!,
    'input_type': _$FieldInputTypeEnumMap[instance.answerType]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('options', instance.options);
  val['is_required'] = instance.isRequired;
  return val;
}

const _$FieldInputTypeEnumMap = {
  FormFieldAnswerType.text: 0,
  FormFieldAnswerType.boolean: 1,
  FormFieldAnswerType.date: 2,
  FormFieldAnswerType.time: 3,
  FormFieldAnswerType.dropDown: 4,
  FormFieldAnswerType.checkBox: 5,
  FormFieldAnswerType.file: 6,
  FormFieldAnswerType.none: 7,
};

const _$FieldTypeEnumMap = {
  FormFieldType.text: 0,
  FormFieldType.image: 1,
};
