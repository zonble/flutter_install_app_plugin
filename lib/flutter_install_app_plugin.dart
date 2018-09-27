import 'dart:async';

import 'package:flutter/services.dart';

/// A container for iOS and Android App IDs.
class AppSet {
  /// The ID on App Store.
  int iosAppId;

  /// The Android package name.
  String androidPackageName;
}

class FlutterInstallAppPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_install_app_plugin');

  static Future<void> installApp(AppSet app) async {
    await _channel
        .invokeMethod('installApp', [app.iosAppId, app.androidPackageName]);
  }
}
