// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      deviceId: json['device_id'] as String?,
      deviceToken: json['device_token'] as String?,
      deviceType: $enumDecodeNullable(_$DeviceTypeEnumMap, json['device_type']),
      version: json['version'] as int?,
      deviceName: json['device_name'] as String?,
      osVersion: json['os_version'] as String?,
      lastAccessedOn: json['last_accessed_on'] as int?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'device_id': instance.deviceId,
      'device_token': instance.deviceToken,
      'device_type': _$DeviceTypeEnumMap[instance.deviceType],
      'version': instance.version,
      'device_name': instance.deviceName,
      'os_version': instance.osVersion,
      'last_accessed_on': instance.lastAccessedOn,
    };

const _$DeviceTypeEnumMap = {
  DeviceType.android: 1,
  DeviceType.ios: 2,
  DeviceType.web: 3,
  DeviceType.macOS: 4,
  DeviceType.linux: 5,
  DeviceType.windows: 6,
};
