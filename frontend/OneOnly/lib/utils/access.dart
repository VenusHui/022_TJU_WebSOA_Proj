import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

abstract class Access {
  static Future<bool> photos() async {
    if (Platform.isIOS) {
      final result = await [Permission.photos].request();
      return result[Permission.photos] == PermissionStatus.granted ||
          result[Permission.photos] == PermissionStatus.limited;
    }
    if (Platform.isAndroid) {
      final result = await [Permission.storage].request();
      return result[Permission.storage] == PermissionStatus.granted;
    }
    return false;
  }

  static Future<void> setting() async => await openAppSettings();
}
