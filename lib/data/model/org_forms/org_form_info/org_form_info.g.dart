// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_form_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgFormInfo _$OrgFormInfoFromJson(Map<String, dynamic> json) => OrgFormInfo(
      createdAt: const DateTimeConverter().fromJson(json['created_at'] as int),
      id: json['id'] as String,
      title: json['title'] as String,
      headerImage: json['header_image'] as String?,
      description: json['description'] as String?,
      oneTimeResponse: json['one_time_response'] as bool? ?? false,
    );

Map<String, dynamic> _$OrgFormInfoToJson(OrgFormInfo instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
    'created_at': const DateTimeConverter().toJson(instance.createdAt),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('header_image', instance.headerImage);
  val['one_time_response'] = instance.oneTimeResponse;
  return val;
}
