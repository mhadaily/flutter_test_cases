import 'dart:async';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Handles infinite timers gracefully', () {
    fakeAsync((fake) {
      var counter = 0;
      final timer = Timer.periodic(Duration(seconds: 1), (_) => counter++);

      fake.elapse(Duration(seconds: 10));

      expect(counter, 10);

      timer.cancel(); // 👈 Cancel to prevent infinite future scheduling
      fake.flushTimers();
      // No pending timers left to cause issues.
    });
  });

  test('Captures exception from periodic timer callback', () {
    fakeAsync((fake) {
      var counter = 0;
      Object? caughtError;

      final timer = Timer.periodic(Duration(seconds: 1), (_) {
        counter++;
        if (counter == 5) {
          try {
            throw Exception('Timer error');
          } catch (e) {
            caughtError = e;
          }
        }
      });

      fake.elapse(Duration(seconds: 10));

      expect(counter, 10);
      expect(caughtError, isA<Exception>());
      timer.cancel(); // cancel and then clean up
      fake.flushTimers(); // Clean up
    });
  });
}
