import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginRequest {
  String googleIdToken;
  String email;
  int deviceType;
  String deviceId;
  int version;
  String deviceName;
  String osVersion;

  LoginRequest(
      {required this.googleIdToken,
      required this.email,
      required this.deviceType,
      required this.deviceId,
      required this.version,
      required this.deviceName,
      required this.osVersion});

  Map<String, dynamic> loginRequestToJson(LoginRequest deviceInfo) {
    return <String, dynamic>{
      "google_id_token": deviceInfo.googleIdToken,
      "email": deviceInfo.email,
      "device_type": deviceInfo.deviceType,
      "device_id": deviceInfo.deviceId,
      "version": deviceInfo.version,
      "device_name": deviceInfo.deviceName,
      "os_version": deviceInfo.osVersion
    };
  }
}
