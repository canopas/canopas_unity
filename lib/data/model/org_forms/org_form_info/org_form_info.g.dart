// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_form_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgFormInfo _$OrgFormInfoFromJson(Map<String, dynamic> json) => OrgFormInfo(
  createdAt: const DateTimeConverter().fromJson(
    (json['created_at'] as num).toInt(),
  ),
  id: json['id'] as String,
  title: json['title'] as String,
  headerImage: json['header_image'] as String?,
  description: json['description'] as String?,
  oneTimeResponse: json['one_time_response'] as bool? ?? false,
);

Map<String, dynamic> _$OrgFormInfoToJson(OrgFormInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'description': ?instance.description,
      'header_image': ?instance.headerImage,
      'one_time_response': instance.oneTimeResponse,
    };
