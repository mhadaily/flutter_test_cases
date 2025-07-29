import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_cases/responsive2.dart';

void main() {
  // Test for narrow screens (width < 600): Expects Drawer layout.
  testWidgets('Displays Drawer on narrow screens', (tester) async {
    // ARRANGE: Simulate a narrow screen (phone-like) within MaterialApp.
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)), // Width < 600
          child: const ResponsiveWidget(),
        ),
      ),
    );

    // ACT: Open the drawer by tapping the default AppBar menu button.
    await tester.tap(
      find.byIcon(Icons.menu),
    ); // Assumes default AppBar menu icon
    await tester.pumpAndSettle(); // Wait for drawer animation to complete

    // ASSERT: Verify Drawer and its contents are present, and NavigationRail is absent.
    expect(find.byType(Drawer), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget); // Drawer contains ListView
    expect(find.text('Item 1'), findsOneWidget); // Drawer item check
    expect(find.text('Item 2'), findsOneWidget); // Drawer item check
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.text('Phone Layout'), findsOneWidget); // AppBar title check
    expect(find.text('Main Content'), findsOneWidget);
  });

  // Test for wide screens (width >= 600): Expects NavigationRail layout.
  testWidgets('Displays NavigationRail on wide screens', (tester) async {
    // ARRANGE: Simulate a wide screen (tablet-like) within MaterialApp.
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(800, 600)), // Width >= 600
          child: const ResponsiveWidget(),
        ),
      ),
    );

    // ASSERT: Verify NavigationRail is present, and Drawer is absent.
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(Drawer), findsNothing);
    expect(find.text('Tablet Layout'), findsOneWidget); // AppBar title check
    expect(find.text('Main Content'), findsOneWidget);
  });

  // Test interaction on narrow screen: Selecting an item in Drawer updates state.
  testWidgets('Updates selected index on Drawer item tap (narrow screen)', (
    tester,
  ) async {
    // ARRANGE: Narrow screen with Drawer within MaterialApp.
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: const ResponsiveWidget(),
        ),
      ),
    );

    // ACT: Open the Drawer and tap the second item ('Item 2').
    await tester.tap(find.byIcon(Icons.menu)); // Default AppBar menu icon
    await tester.pumpAndSettle();
    await tester.tap(find.text('Item 2'));
    await tester.pumpAndSettle();

    // ASSERT: Verify the second item is selected (selectedIndex == 1).
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is ListTile &&
            widget.title is Text &&
            (widget.title as Text).data == 'Item 2' &&
            widget.selected == true,
      ),
      findsOneWidget,
    );
  });

  // Test interaction on wide screen: Selecting an item in NavigationRail updates state.
  testWidgets(
    'Updates selected index on NavigationRail selection (wide screen)',
    (tester) async {
      // ARRANGE: Wide screen with NavigationRail within MaterialApp.
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 600)),
            child: const ResponsiveWidget(),
          ),
        ),
      );

      // ACT: Select the second destination ('Item 2').
      await tester.tap(
        find.byIcon(Icons.bookmark_border),
      ); // Icon for second item
      await tester.pumpAndSettle();

      // ASSERT: Verify the second item is selected (selectedIndex == 1).
      final navigationRail = tester.widget<NavigationRail>(
        find.byType(NavigationRail),
      );
      expect(navigationRail.selectedIndex, 1);
    },
  );

  // Edge case: Test exactly at breakpoint (width == 600) – should use wide layout.
  testWidgets('Uses NavigationRail at exact breakpoint', (tester) async {
    // ARRANGE: Exact breakpoint within MaterialApp.
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(600, 800)),
          child: const ResponsiveWidget(),
        ),
      ),
    );

    // ASSERT: Verify NavigationRail is used at the breakpoint.
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(Drawer), findsNothing);
  });
}
