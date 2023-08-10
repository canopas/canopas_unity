// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgFormField _$OrgFormFieldFromJson(Map<String, dynamic> json) => OrgFormField(
      id: json['id'] as String,
      index: json['index'] as int,
      question: json['question'] as String,
      inputType:
          $enumDecodeNullable(_$FieldInputTypeEnumMap, json['input_type']) ??
              FieldInputType.text,
      type: $enumDecodeNullable(_$FieldTypeEnumMap, json['type']) ??
          FieldType.text,
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
    'input_type': _$FieldInputTypeEnumMap[instance.inputType]!,
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
  FieldInputType.text: 0,
  FieldInputType.boolean: 1,
  FieldInputType.date: 2,
  FieldInputType.time: 3,
  FieldInputType.dropDown: 4,
  FieldInputType.checkBox: 5,
  FieldInputType.file: 6,
  FieldInputType.none: 7,
};

const _$FieldTypeEnumMap = {
  FieldType.text: 0,
  FieldType.image: 1,
};
