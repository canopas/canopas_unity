import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_data.g.dart';

@JsonSerializable()
class LoginRequestData {
  @JsonKey(name:"google_id_token" )
  String googleIdToken;
  String email;
  @JsonKey(name:"device_type" )
  int deviceType;
  @JsonKey(name: "device_id")
  String deviceId;
  int version;
  @JsonKey(name: "device_name")
  String deviceName;
  @JsonKey(name: "os_version")
  String osVersion;

  LoginRequestData(
      {required this.googleIdToken,
      required this.email,
      required this.deviceType,
      required this.deviceId,
      required this.version,
      required this.deviceName,
      required this.osVersion});

  Map<String, dynamic> toJson(LoginRequestData deviceInfo) => _$LoginRequestDataToJson(this);

}
