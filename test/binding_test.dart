import 'package:flutter_test/flutter_test.dart';

void main() {
  // Manual initialization is required here.
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Future.delayed completes after time is advanced in FakeAsync', (
    tester,
  ) async {
    // runAsync gives access to a FakeAsync zone.
    tester.runAsync(() async {
      bool futureCompleted = false;
      Future.delayed(const Duration(seconds: 5)).then((_) {
        futureCompleted = true;
      });

      // Advance the test clock by 5 seconds.
      await tester.binding.delayed(const Duration(seconds: 5));

      expect(futureCompleted, isTrue);
    });
  });
}
