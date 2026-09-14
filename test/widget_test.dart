// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vellio/components/submit_button.dart';


import 'package:vellio/screens/name_input_screen.dart';

void main() {
  testWidgets("Landing screen renders accurately", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: NameInput()));
    final button = find.byType(LNSubmitButton);
    expect(button, findsOneWidget);
    await tester.enterText(find.byType(TextField), "Jim");
    await tester.pump();
    ElevatedButton subBtn = tester.widget(find.byType(ElevatedButton));
    expect(
      subBtn.onPressed,
      isNull,
      reason: "Name must be 4 or more characters",
    );
    await tester.enterText(find.byType(TextField), "Neal Watson");
    await tester.pump();
    subBtn = tester.widget(find.byType(ElevatedButton));
    expect(subBtn.onPressed, isNotNull, reason: "Characters inputted are greater than 4");
    await tester.tap(find.text("Continue"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Select your Primary Categories'), findsOneWidget);
  });
}

