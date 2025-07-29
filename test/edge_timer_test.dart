import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  // This must be called once before using the timezone package.
  tz.initializeTimeZones();
  final newYork = tz.getLocation('America/New_York');

  group('Date logic with a controlled clock', () {
    test('Correctly handles the end of February on a LEAP year', () {
      withClock(Clock.fixed(DateTime.utc(2024, 2, 28)), () {
        final tomorrow = clock.now().add(const Duration(days: 1));
        expect(tomorrow, DateTime.utc(2024, 2, 29));
      });
    });

    test('Correctly handles the end of February on a NON-LEAP year', () {
      withClock(Clock.fixed(DateTime.utc(2023, 2, 28)), () {
        final tomorrow = clock.now().add(const Duration(days: 1));
        expect(tomorrow, DateTime.utc(2023, 3, 1));
      });
    });

    test('Ensures consistent time regardless of system timezone', () {
      withClock(Clock.fixed(DateTime.utc(2025, 7, 28, 10, 30)), () {
        expect(clock.now().hour, 10);
        expect(clock.now().isUtc, isTrue);
      });
    });

    test('Correctly handles a Daylight Saving Time forward jump', () {
      // In America/New_York on March 10, 2024, the clock jumps
      // from 1:59:59 AM to 3:00:00 AM.
      final beforeDST = tz.TZDateTime(newYork, 2024, 3, 10, 1, 59);

      withClock(Clock.fixed(beforeDST), () {
        final afterDST = clock.now().add(const Duration(minutes: 1));
        // Convert the resulting UTC time back to the local timezone
        // to observe the jump.
        final localAfterDST = tz.TZDateTime.from(afterDST, newYork);

        expect(localAfterDST.hour, 3);
        expect(localAfterDST.minute, 0);
      });
    });
  });
}
