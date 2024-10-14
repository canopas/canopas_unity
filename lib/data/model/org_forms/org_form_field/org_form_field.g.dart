// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgFormField _$OrgFormFieldFromJson(Map<String, dynamic> json) => OrgFormField(
      id: json['id'] as String,
      index: (json['index'] as num).toInt(),
      question: json['question'] as String,
      answerType: $enumDecodeNullable(
              _$FormFieldAnswerTypeEnumMap, json['answer_type']) ??
          FormFieldAnswerType.text,
      type: $enumDecodeNullable(_$FormFieldTypeEnumMap, json['type']) ??
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
    'type': _$FormFieldTypeEnumMap[instance.type]!,
    'answer_type': _$FormFieldAnswerTypeEnumMap[instance.answerType]!,
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

const _$FormFieldAnswerTypeEnumMap = {
  FormFieldAnswerType.text: 0,
  FormFieldAnswerType.boolean: 1,
  FormFieldAnswerType.date: 2,
  FormFieldAnswerType.time: 3,
  FormFieldAnswerType.dropDown: 4,
  FormFieldAnswerType.checkBox: 5,
  FormFieldAnswerType.file: 6,
  FormFieldAnswerType.none: 7,
};

const _$FormFieldTypeEnumMap = {
  FormFieldType.text: 0,
  FormFieldType.image: 1,
};
