// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestData _$LoginRequestDataFromJson(Map<String, dynamic> json) =>
    LoginRequestData(
      googleIdToken: json['google_id_token'] as String,
      email: json['email'] as String,
      deviceType: json['device_type'] as int,
      deviceId: json['device_id'] as String,
      version: json['version'] as int,
      deviceName: json['device_name'] as String,
      osVersion: json['os_version'] as String,
    );

Map<String, dynamic> _$LoginRequestDataToJson(LoginRequestData instance) =>
    <String, dynamic>{
      'google_id_token': instance.googleIdToken,
      'email': instance.email,
      'device_type': instance.deviceType,
      'device_id': instance.deviceId,
      'version': instance.version,
      'device_name': instance.deviceName,
      'os_version': instance.osVersion,
    };
