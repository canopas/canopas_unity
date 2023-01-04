class DeviceTypeConst{

static  const int android = 1;
static  const int ios = 2;
}


class DeviceInfo {
  int deviceType;
  String deviceId;
  int version;
  String deviceName;
  String osVersion;

  DeviceInfo(
      {required this.deviceType,
      required this.deviceId,
      required this.version,
      required this.deviceName,
      required this.osVersion});
}
