import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import '../model/session/session.dart';

@Injectable()
class DeviceInfoProvider {
  final DeviceInfoPlugin deviceInfoPlugin;

  DeviceInfoProvider(this.deviceInfoPlugin);

  Future<Session?> getDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      if (kIsWeb) {
        WebBrowserInfo webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
        return Session(
            lastAccessedOn: DateTime.now().timeStampToInt,
            deviceType: DeviceType.web,
            deviceId: webBrowserInfo.appVersion,
            version: int.parse(packageInfo.buildNumber),
            deviceName: webBrowserInfo.browserName.name,
            osVersion: webBrowserInfo.platform);
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        return Session(
          lastAccessedOn: DateTime.now().timeStampToInt,
          deviceType: DeviceType.android,
          deviceId: androidInfo.id,
          version: int.parse(packageInfo.buildNumber),
          deviceName: androidInfo.model,
          osVersion: androidInfo.version.release,
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        return Session(
            lastAccessedOn: DateTime.now().timeStampToInt,
            deviceType: DeviceType.ios,
            deviceId: iosInfo.identifierForVendor,
            version: int.parse(packageInfo.buildNumber),
            deviceName: iosInfo.utsname.machine,
            osVersion: iosInfo.systemVersion);
      } else if (defaultTargetPlatform == TargetPlatform.macOS) {
        MacOsDeviceInfo macInfo = await deviceInfoPlugin.macOsInfo;
        return Session(
            lastAccessedOn: DateTime.now().timeStampToInt,
            deviceType: DeviceType.macOS,
            deviceId: macInfo.systemGUID,
            version: int.parse(packageInfo.buildNumber),
            deviceName: macInfo.model,
            osVersion:
                "${macInfo.majorVersion}.${macInfo.minorVersion}.${macInfo.patchVersion}");
      } else if (defaultTargetPlatform == TargetPlatform.linux) {
        LinuxDeviceInfo linuxInfo = await deviceInfoPlugin.linuxInfo;
        return Session(
            lastAccessedOn: DateTime.now().timeStampToInt,
            deviceType: DeviceType.linux,
            deviceId: linuxInfo.id,
            version: int.parse(packageInfo.buildNumber),
            deviceName: linuxInfo.name,
            osVersion: linuxInfo.version);
      } else if (defaultTargetPlatform == TargetPlatform.windows) {
        WindowsDeviceInfo windowsInfo = await deviceInfoPlugin.windowsInfo;
        return Session(
            lastAccessedOn: DateTime.now().timeStampToInt,
            deviceType: DeviceType.windows,
            deviceId: windowsInfo.deviceId,
            version: int.parse(packageInfo.buildNumber),
            deviceName: windowsInfo.productName,
            osVersion:
                "${windowsInfo.majorVersion}.${windowsInfo.minorVersion}");
      }
    } on Exception {
      return null;
    }
    return null;
  }
}
