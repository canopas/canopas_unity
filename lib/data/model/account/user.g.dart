// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      spaces: (json['spaces'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['spaces'] = instance.spaces;
  return val;
}
