// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  uid: json['uid'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
  spaces:
      (json['spaces'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'name': ?instance.name,
  'spaces': instance.spaces,
};
