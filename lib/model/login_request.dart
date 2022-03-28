class LoginRequestData {
  String googleIdToken;
  String email;
  int deviceType;
  String deviceId;
  int version;
  String deviceName;
  String osVersion;

  LoginRequestData(
      {required this.googleIdToken,
      required this.email,
      required this.deviceType,
      required this.deviceId,
      required this.version,
      required this.deviceName,
      required this.osVersion});

  Map<String, dynamic> loginRequestToJson(LoginRequestData deviceInfo) {
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
