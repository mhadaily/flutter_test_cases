import 'package:flutter_test_cases/time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('progress bar completes after 3 seconds', (tester) async {
    await tester.pumpWidget(MaterialApp(home: DelayedProgressWidget()));

    // Initially, progress should be zero.
    var progressIndicator = tester.widget<LinearProgressIndicator>(
      find.byType(LinearProgressIndicator),
    );
    expect(progressIndicator.value, 0.0);

    // Simulate 1 second passing.
    await tester.pump(Duration(seconds: 1));
    progressIndicator = tester.widget(find.byType(LinearProgressIndicator));
    expect(progressIndicator.value, closeTo(1 / 3, 0.01));

    // Simulate total of 3 seconds passing.
    await tester.pump(Duration(seconds: 2));
    progressIndicator = tester.widget(find.byType(LinearProgressIndicator));
    expect(progressIndicator.value, closeTo(1.0, 0.01));
  });

  testWidgets('Handles timer cancellation edge case', (tester) async {
    await tester.pumpWidget(MaterialApp(home: DelayedProgressWidget()));
    var progressIndicator = tester.widget<LinearProgressIndicator>(
      find.byType(LinearProgressIndicator),
    );
    expect(progressIndicator.value, 0.0);

    // Simulate partial progress
    await tester.pump(Duration(seconds: 1));
    progressIndicator = tester.widget(find.byType(LinearProgressIndicator));
    expect(progressIndicator.value, closeTo(1 / 3, 0.01));

    // Simulate cancellation by disposing widget early
    await tester.pumpWidget(Container()); // Remove widget
    await tester.pump(Duration(seconds: 2)); // No further progress
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });
}
