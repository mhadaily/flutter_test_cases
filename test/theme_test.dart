import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_cases/theme_helper.dart';

void main() {
  group('ThemeHelper (uses BuildContext)', () {
    testWidgets('returns primary color from Theme.of(context)', (tester) async {
      final themeHelper = ThemeHelper();
      late BuildContext context;
      const testPrimaryColor = Colors.teal;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light().copyWith(
              primary: testPrimaryColor,
            ),
          ),
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final result = themeHelper.getPrimaryColor(context);
      expect(result, testPrimaryColor);
    });
  });

  group('RefactoredThemeHelper (pure Dart)', () {
    test('returns custom primary color from ThemeData', () {
      final helper = RefactoredThemeHelper();
      const customColor = Colors.deepOrange;
      final theme = ThemeData(
        colorScheme: const ColorScheme.light().copyWith(primary: customColor),
      );

      final result = helper.getPrimaryColor(theme);
      expect(result, customColor);
    });

    test('returns transparent for transparent primary color', () {
      final helper = RefactoredThemeHelper();
      final theme = ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.transparent),
      );

      final result = helper.getPrimaryColor(theme);
      expect(result, Colors.transparent);
    });

    test(
      'returns correct color for default ThemeData (Material 3 default)',
      () {
        final helper = RefactoredThemeHelper();
        final theme = ThemeData(); // Default ThemeData

        final expectedColor = theme.colorScheme.primary;
        final result = helper.getPrimaryColor(theme);

        expect(result, expectedColor);
      },
    );
  });
}
