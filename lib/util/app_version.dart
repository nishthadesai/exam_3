import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  static String? appVersion;

  static Future<String> getVersion() async {
    if (appVersion == null) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
    }
    return appVersion ?? "";
  }
}
