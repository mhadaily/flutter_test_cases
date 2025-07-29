import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:canvas_test/canvas_test.dart';
import 'package:flutter_test_cases/custompainter.dart';

void main() {
  test('MySimplePainter issues the correct drawRect command', () {
    // ARRANGE
    final mockCanvas = MockCanvas();
    final painter = MySimplePainter();
    const size = Size(100, 100);

    // ACT: Call the paint method with the mock canvas.
    painter.paint(mockCanvas, size);

    // ASSERT: Verify that the mock canvas received the expected commands.
    // The second MockCanvas acts as a "matcher" that describes the expected
    // sequence of drawing calls. The `paint` argument is optional.
    expect(
      mockCanvas,
      MockCanvas()..drawRect(const Rect.fromLTWH(10, 10, 50, 50)),
    );
  });
}
