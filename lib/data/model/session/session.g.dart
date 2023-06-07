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
      lastAccessedOn: _$JsonConverterFromJson<int, DateTime>(
          json['last_accessed_on'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$SessionToJson(Session instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('device_id', instance.deviceId);
  writeNotNull('device_token', instance.deviceToken);
  writeNotNull('device_type', _$DeviceTypeEnumMap[instance.deviceType]);
  writeNotNull('version', instance.version);
  writeNotNull('device_name', instance.deviceName);
  writeNotNull('os_version', instance.osVersion);
  writeNotNull(
      'last_accessed_on',
      _$JsonConverterToJson<int, DateTime>(
          instance.lastAccessedOn, const DateTimeConverter().toJson));
  return val;
}

const _$DeviceTypeEnumMap = {
  DeviceType.android: 1,
  DeviceType.ios: 2,
  DeviceType.web: 3,
  DeviceType.macOS: 4,
  DeviceType.linux: 5,
  DeviceType.windows: 6,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
