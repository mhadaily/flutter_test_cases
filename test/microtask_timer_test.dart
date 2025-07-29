import 'dart:async';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Handles microtask scheduling', () {
    fakeAsync((fake) {
      var executed = false;
      scheduleMicrotask(() => executed = true);

      expect(executed, isFalse);
      fake.flushMicrotasks();
      expect(executed, isTrue);
    });
  });

  test('Handles stream emissions', () {
    fakeAsync((fake) {
      final controller = StreamController<int>();
      final timer = Timer.periodic(
        Duration(seconds: 1),
        (_) => controller.add(1),
      );

      final emissions = <int>[];
      controller.stream.listen(emissions.add);

      fake.elapse(Duration(seconds: 3));
      expect(emissions, [1, 1, 1]);

      timer.cancel(); // 👈 Important
      controller.close(); // 👈 Clean up
      fake.flushTimers();
    });
  });

  test('Handles stream error with await', () async {
    final controller = StreamController<int>();

    final timer = Timer(Duration(milliseconds: 10), () {
      controller.addError(Exception('Stream error'));
    });

    await expectLater(controller.stream.first, throwsA(isA<Exception>()));

    await controller.close();
    timer.cancel();
  });

  test('Handles stream error (no async)', () {
    fakeAsync((fake) {
      final controller = StreamController<int>();
      Object? caughtError;

      // Schedule a periodic timer that adds an error to the stream
      final timer = Timer.periodic(Duration(seconds: 1), (_) {
        controller.addError(Exception('Stream error'));
      });

      // Attach a listener to capture the error
      controller.stream.listen((_) {}, onError: (error) => caughtError = error);

      // Advance fake time by 1 second so the timer fires once
      fake.elapse(Duration(seconds: 1));

      expect(caughtError, isA<Exception>());

      controller.close();
      timer.cancel();
      fake.flushTimers();
    });
  });
}
