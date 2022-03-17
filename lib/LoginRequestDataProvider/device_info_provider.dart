import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:projectunity/model/login_request.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:projectunity/utils/service_locator.dart';

class LoginRequestDataProvider {
  DeviceInfoPlugin deviceInfoPlugin = getIt<DeviceInfoPlugin>();
  late LoginRequest loginRequest;

  Future<LoginRequest> getLoginRequestData(
      String googleIdToken, String email) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        loginRequest = LoginRequest(
          googleIdToken: googleIdToken,
          email: email,
          deviceType: androidDeviceType,
          deviceId: androidInfo.androidId!,
          version: int.parse(packageInfo.buildNumber),
          deviceName: androidInfo.model!,
          osVersion: androidInfo.version.toString(),
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        loginRequest = LoginRequest(
            googleIdToken: googleIdToken,
            email: email,
            deviceType: iosDeviceType,
            deviceId: iosInfo.identifierForVendor!,
            version: int.parse(packageInfo.buildNumber),
            deviceName: iosInfo.name!,
            osVersion: iosInfo.systemVersion!);
      }
    } on PlatformException {
      throw Exception('Failed to get platform version');
    }
    return loginRequest;
  }
}
