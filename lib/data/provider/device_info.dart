import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../model/device_info/device_info.dart';
import '../model/session/session.dart';

@Injectable()
class DeviceInfoProvider {
  final DeviceInfoPlugin deviceInfoPlugin;

  DeviceInfoProvider(this.deviceInfoPlugin);

  Future<Session?> getDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        return Session(
          deviceType: DeviceType.android,
          deviceId: androidInfo.id,
          version: int.parse(packageInfo.buildNumber),
          deviceName: androidInfo.model,
          osVersion: androidInfo.version.release,
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        return Session(
            deviceType: DeviceType.ios,
            deviceId: iosInfo.identifierForVendor!,
            version: int.parse(packageInfo.buildNumber),
            deviceName: iosInfo.name!,
            osVersion: iosInfo.systemVersion!);
      } else if(kIsWeb){
         WebBrowserInfo webBrowserInfo =  await deviceInfoPlugin.webBrowserInfo;
         return Session(
             deviceType: DeviceType.web,
             deviceId: webBrowserInfo.appCodeName,
             version: int.parse(packageInfo.buildNumber),
             deviceName: webBrowserInfo.browserName.name,
             osVersion: webBrowserInfo.platform);
      }

    } on Exception {
      return null;
    }
    return null;
  }
}
