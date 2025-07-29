import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_cases/responsive.dart';

void main() {
  testWidgets('layout adapts to parent constraints with LayoutBuilder', (
    tester,
  ) async {
    // Helper function to pump the widget with a specific parent width.
    Future<void> pumpWithWidth(double width) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(width: width, child: const OrientationWidget()),
          ),
        ),
      );
      // A single pump is sufficient here; pumpAndSettle is for animations.
      await tester.pump();
    }

    // ARRANGE & ASSERT: Narrow layout (Column)
    await pumpWithWidth(300);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Row), findsNothing);

    // ARRANGE & ASSERT: Wide layout (Row)
    await pumpWithWidth(500);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Column), findsNothing);
  });
}
