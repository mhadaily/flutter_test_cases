import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_cases/fade.dart';

void main() {
  testWidgets('widget fades in correctly over its duration', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: FadeInWidget(child: const Text('hello'))),
    );

    // After half the duration, opacity should be around 0.5.
    // Use pump() to check an intermediate state.
    await tester.pump(const Duration(milliseconds: 500));
    var fadeTransition = tester.widget<FadeTransition>(
      find.byType(FadeTransition),
    );
    expect(fadeTransition.opacity.value, closeTo(0.5, 0.01));

    // Use pumpAndSettle() to complete the animation.
    await tester.pumpAndSettle();
    fadeTransition = tester.widget<FadeTransition>(find.byType(FadeTransition));
    expect(fadeTransition.opacity.value, 1.0);
  });
}
