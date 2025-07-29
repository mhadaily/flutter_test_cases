import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_cases/connectivity_service.dart';
import 'package:flutter_test_cases/connectivity_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'connectivity_widget_test.mocks.dart';

@GenerateMocks([ConnectivityService])
void main() {
  testWidgets('shows Offline banner when connection is none', (tester) async {
    // ARRANGE: Create the mock and stub it to return a list containing .none
    final mockService = MockConnectivityService();
    when(
      mockService.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.none]);

    // ACT: Pump the widget
    await tester.pumpWidget(
      MaterialApp(home: ConnectivityBanner(connectivityService: mockService)),
    );
    await tester.pump(); // Let the FutureBuilder resolve

    // ASSERT
    expect(find.text('Offline'), findsOneWidget);
  });

  testWidgets('shows Online banner when connection is WiFi', (tester) async {
    // ARRANGE: Stub the mock to return a list containing .wifi
    final mockService = MockConnectivityService();
    when(
      mockService.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    // ACT
    await tester.pumpWidget(
      MaterialApp(home: ConnectivityBanner(connectivityService: mockService)),
    );
    await tester.pump();

    // ASSERT
    expect(find.text('Online'), findsOneWidget);
  });
}
