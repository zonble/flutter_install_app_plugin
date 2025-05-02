import 'package:flutter/material.dart';
import 'package:flutter_install_app_plugin_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verify Platform version', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that platform version is retrieved.
    expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Text &&
              (widget.data?.startsWith('Install App') ?? false),
        ),
        findsOneWidget);
  });
}
