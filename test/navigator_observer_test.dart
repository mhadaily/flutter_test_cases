import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_cases/navigation.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'navigator_observer_test.mocks.dart';

// 1. Annotate the test file to generate a mock for NavigatorObserver.
@GenerateNiceMocks([MockSpec<NavigatorObserver>()])
void main() {
  testWidgets('navigation call is verified by mock observer', (tester) async {
    // ARRANGE: Create the mock and build the app with the mock observer.
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: const MyHomePage(),
        navigatorObservers: [mockObserver], // Provide the mock here
      ),
    );

    // Clear any navigation from initial build
    reset(mockObserver);

    // ACT: Tap the item that triggers the navigation.
    await tester.tap(find.byKey(const Key('item_to_tap')));
    await tester
        .pumpAndSettle(); // pump() is enough to trigger the method call.

    // ASSERT: Verify that didPush was called on our mock observer.
    // The `any` matcher from Mockito means we don't care about the arguments,
    // only that the method was called.
    verify(mockObserver.didPush(any, any)).called(1);
  });
}
