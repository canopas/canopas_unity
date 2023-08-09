// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormInfo _$FormInfoFromJson(Map<String, dynamic> json) => FormInfo(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String?,
      description: json['description'] as String?,
      oneTimeResponse: json['one_time_response'] as bool? ?? false,
    );

Map<String, dynamic> _$FormInfoToJson(FormInfo instance) {
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
  writeNotNull('image', instance.image);
  val['one_time_response'] = instance.oneTimeResponse;
  return val;
}
