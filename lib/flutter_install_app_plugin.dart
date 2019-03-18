import 'dart:async';

import 'package:flutter/services.dart';

/// A container for iOS and Android App IDs.
class AppSet {
  /// The ID on App Store.
  int iosAppId;

  /// The Android package name.
  String androidPackageName;
}

/// The plugin that helps to guide users to install apps.
///
/// To use the plugin, create an instance of [AppSet] and then pass it to
/// [FlutterInstallAppPlugin.installApp].
class FlutterInstallAppPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_install_app_plugin');

  /// Invokes the user interface on the current platform to install other apps.
  static Future<void> installApp(AppSet app) async {
    await _channel
        .invokeMethod('installApp', [app.iosAppId, app.androidPackageName]);
  }
}
