import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpApp({required Widget widgetUnderTest}) {
    return pumpWidget(
      MaterialApp(home: widgetUnderTest, theme: ThemeData(useMaterial3: true)),
    );
  }
}
