import 'dart:io' as io;
import 'package:device_info_plus/device_info_plus.dart';

class TokenRepository {

  Future<String> getDeviceId() async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (io.Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Unique ID for Android
    } else if (io.Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor!; // Unique ID for iOS
    } else {
      throw Exception("Unsupported platform");
    }
  }

}
