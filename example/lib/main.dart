import 'package:flutter/material.dart';
import 'package:flutter_install_app_plugin/flutter_install_app_plugin.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                var app = AppSet()
                  ..iosAppId = 300915900
                  ..androidPackageName = 'com.skysoft.kkbox.android';
                FlutterInstallAppPlugin.installApp(app);
              },
              child: Text(
                'Install App',
                style: TextStyle(color: Colors.white),
              ))),
    ));
  }
}
