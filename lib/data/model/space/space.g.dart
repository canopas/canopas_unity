// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Space _$SpaceFromJson(Map<String, dynamic> json) => Space(
      name: json['name'] as String,
      createdAt: Space._fromJson(json['created_at'] as int),
      paidTimeOff: json['paid_time_off'] as int,
      ownerIds:
          (json['owner_ids'] as List<dynamic>).map((e) => e as String).toList(),
      domain: json['domain'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$SpaceToJson(Space instance) => <String, dynamic>{
      'name': instance.name,
      'created_at': Space._toJson(instance.createdAt),
      'logo': instance.logo,
      'owner_ids': instance.ownerIds,
      'paid_time_off': instance.paidTimeOff,
      'domain': instance.domain,
    };
