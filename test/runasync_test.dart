import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';

Future<String> loadJson() async {
  // Imagine this reads from disk or network
  return await rootBundle.loadString('assets/sample.json');
}

void main() {
  testWidgets('load data using runAsync', (tester) async {
    String data = '';
    await tester.runAsync(() async {
      data = await loadJson();
    });
    expect(jsonDecode(data)['name'], 'Majid');
  });
}
