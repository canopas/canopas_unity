import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/model/Login/device_info.dart';
import 'package:projectunity/rest/data_exception.dart';

class DeviceInfoProvider {
  static Future<Session?> getDeviceInfo() async {
    final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        return Session(
          deviceType: androidDeviceType,
          deviceId: androidInfo.androidId!,
          version: int.parse(packageInfo.buildNumber),
          deviceName: androidInfo.model!,
          osVersion: androidInfo.version.release,
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        return Session(
            deviceType: iosDeviceType,
            deviceId: iosInfo.identifierForVendor!,
            version: int.parse(packageInfo.buildNumber),
            deviceName: iosInfo.name!,
            osVersion: iosInfo.systemVersion!);
      }
    } on PlatformException {
      throw DataException('Failed to get platform version');
    }
    return null;
  }
}
