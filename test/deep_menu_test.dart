import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deep_menu/deep_menu.dart';

void main() {
  Widget _buildWidget() {
    return const MaterialApp(
      home: Scaffold(
        body: DeepMenu(child: Text("Test")),
      ),
    );
  }

  testWidgets('adds one to input values', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget());

    expect(find.text('Test'), findsOneWidget);
  });
}
