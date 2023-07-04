// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Space _$SpaceFromJson(Map<String, dynamic> json) => Space(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: const DateTimeConverter().fromJson(json['created_at'] as int),
      paidTimeOff: json['paid_time_off'] as int,
      ownerIds:
          (json['owner_ids'] as List<dynamic>).map((e) => e as String).toList(),
      domain: json['domain'] as String?,
      logo: json['logo'] as String?,
      notificationEmail: json['notification_email'] as String?,
    );

Map<String, dynamic> _$SpaceToJson(Space instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'created_at': const DateTimeConverter().toJson(instance.createdAt),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('logo', instance.logo);
  val['owner_ids'] = instance.ownerIds;
  val['paid_time_off'] = instance.paidTimeOff;
  writeNotNull('domain', instance.domain);
  writeNotNull('notification_email', instance.notificationEmail);
  return val;
}
