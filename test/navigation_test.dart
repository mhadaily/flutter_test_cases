import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_cases/navigation.dart';

void main() {
  testWidgets('navigates to detail page on tap', (tester) async {
    // ARRANGE: Build the initial page.
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));
    expect(find.byType(SecondPage), findsNothing);

    // ACT: Tap the list item and wait for the navigation animation to settle.
    await tester.tap(find.byKey(const Key('item_to_tap')));
    await tester.pumpAndSettle();

    // ASSERT: Verify the new page has appeared.
    expect(find.byType(SecondPage), findsOneWidget);
  });
}
