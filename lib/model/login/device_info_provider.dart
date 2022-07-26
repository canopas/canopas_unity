import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/login/device_info.dart';

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
      throw Exception('Failed to get platform version');
    }
    return null;
  }
}
