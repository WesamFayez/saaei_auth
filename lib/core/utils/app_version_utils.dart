import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionResult {
  final bool isUpdated;
  final String platformInfo;
  final String currentVersion;

  AppVersionResult({
    required this.isUpdated,
    required this.platformInfo,
    required this.currentVersion,
  });
}

class AppVersionUtils {
  static Future<AppVersionResult> checkAppVersion({
    required String androidVersion,
    required String iosVersion,
  }) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      final version = packageInfo.version;
      final buildNumber = packageInfo.buildNumber;

      bool isUpdated = true;
      String platformInfo;

      if (Platform.isAndroid) {
        isUpdated = androidVersion == version;
        platformInfo = 'Android version: $version (Build $buildNumber)';
      } else if (Platform.isIOS) {
        isUpdated = iosVersion == version;
        platformInfo = 'iOS version: $version (Build $buildNumber)';
      } else {
        platformInfo = 'Other platform version: $version (Build $buildNumber)';
      }

      return AppVersionResult(
        isUpdated: isUpdated,
        platformInfo: platformInfo,
        currentVersion: version,
      );
    } catch (e) {
      return AppVersionResult(
        isUpdated: true,
        platformInfo: 'Unknown',
        currentVersion: 'Unknown',
      );
    }
  }
}
