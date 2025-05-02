import 'package:flutter/material.dart';
import 'package:flutter_install_app_plugin/flutter_install_app_plugin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
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
              child: const Text(
                'Install App',
                style: TextStyle(color: Colors.white),
              ))),
    ));
  }
}
