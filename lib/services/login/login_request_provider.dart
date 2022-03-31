import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:projectunity/model/login_request.dart';
import 'package:projectunity/utils/constant.dart';

@Injectable()
class LoginRequestDataProvider {
  late LoginRequestData _loginRequestData;

  Future<LoginRequestData> getLoginRequestData(
      String googleIdToken, String email) async {
    final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        _loginRequestData = LoginRequestData(
          googleIdToken: googleIdToken,
          email: email,
          deviceType: androidDeviceType,
          deviceId: androidInfo.androidId!,
          version: int.parse(packageInfo.buildNumber),
          deviceName: androidInfo.model!,
          osVersion: androidInfo.version.toString(),
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        _loginRequestData = LoginRequestData(
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
    return _loginRequestData;
  }
}
