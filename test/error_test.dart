import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_cases/error.dart';

void main() {
  testWidgets(
    'shows an error message when the repository throws an exception',
    (tester) async {
      // ARRANGE: Pump the widget with the fake repository.
      await tester.pumpWidget(
        MaterialApp(home: MyErrorWidget(repo: FakeRepository())),
      );

      // ACT: Wait for the Future to complete and the UI to update.
      await tester.pumpAndSettle();

      // ASSERT: Verify the error message is displayed.
      expect(find.byKey(const Key('error_message')), findsOneWidget);
    },
  );
}
