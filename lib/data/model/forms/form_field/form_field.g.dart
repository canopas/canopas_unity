// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormField _$FormFieldFromJson(Map<String, dynamic> json) => FormField(
      id: json['id'] as String,
      title: json['title'] as String,
      inputType:
          $enumDecodeNullable(_$FieldInputTypeEnumMap, json['input_type']) ??
              FieldInputType.text,
      type: $enumDecodeNullable(_$FieldTypeEnumMap, json['type']) ??
          FieldType.text,
      isRequired: json['is_required'] as bool? ?? false,
      description: json['description'] as String?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FormFieldToJson(FormField instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['type'] = _$FieldTypeEnumMap[instance.type]!;
  val['input_type'] = _$FieldInputTypeEnumMap[instance.inputType]!;
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
  FieldInputType.noInput: 7,
};

const _$FieldTypeEnumMap = {
  FieldType.text: 0,
  FieldType.image: 1,
};
