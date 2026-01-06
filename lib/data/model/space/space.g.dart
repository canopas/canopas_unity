// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Space _$SpaceFromJson(Map<String, dynamic> json) => Space(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: const DateTimeConverter().fromJson(
    (json['created_at'] as num).toInt(),
  ),
  paidTimeOff: (json['paid_time_off'] as num).toInt(),
  ownerIds: (json['owner_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  domain: json['domain'] as String?,
  logo: json['logo'] as String?,
  notificationEmail: json['notification_email'] as String?,
);

Map<String, dynamic> _$SpaceToJson(Space instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'created_at': const DateTimeConverter().toJson(instance.createdAt),
  'logo': ?instance.logo,
  'owner_ids': instance.ownerIds,
  'paid_time_off': instance.paidTimeOff,
  'domain': ?instance.domain,
  'notification_email': ?instance.notificationEmail,
};
