import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:platform_detect/platform_detect.dart';

class FlutterInstallAppPlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel('flutter_install_app_plugin',
        const StandardMethodCodec(), registrar.messenger);
    final FlutterInstallAppPlugin instance = FlutterInstallAppPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'installApp':
        final String? jsonString = call.arguments;
        if (jsonString is String) {
          Map map = json.decode(jsonString);
          final url = _urlFromMap(map);
          if (url != null) return _launch(url);
        }
        throw PlatformException(
          code: 'Invalid parameters',
          details: 'A json string containing required parameters is required.',
        );
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "The url_launcher plugin for web doesn't implement "
                "the method '${call.method}'");
    }
  }

  _launch(String url) => html.window.open(url, '');

  String? _urlFromMap(Map map) {
    if (map['url'] != null) return map['url'];
    if (browser.isSafari && map['iosAppId'] != null) {
      return 'https://apps.apple.com/jp/app/${map['iosAppId']}';
    }
    if (map['androidPackageName'] != null) {
      return 'https://play.google.com/store/apps/details?id=${map['androidPackageName']}';
    }
    return null;
  }
}
