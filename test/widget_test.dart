// This is a basic Flutter widget test for the macOS portfolio

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:macos_portfolio/main.dart';

void main() {
  testWidgets('MacOS Portfolio loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MacOsPortfolioApp());

    // Verify that the app loads without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
