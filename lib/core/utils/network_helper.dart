import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  /// Checks if the device has internet access.
  static Future<bool> hasConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false; // no WiFi or mobile data
    }

    // Extra check: actually try to ping a known server (e.g. Google DNS)
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Checks if the connection is too slow by measuring response time.
  static Future<bool> isConnectionSlow() async {
    try {
      final stopwatch = Stopwatch()..start();
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      stopwatch.stop();

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // if ping takes longer than 2s, consider it slow
        return stopwatch.elapsedMilliseconds > 2000;
      }
    } catch (_) {
      return true; // if failed, assume slow
    }
    return false;
  }
}
