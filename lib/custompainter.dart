import 'package:flutter/material.dart';

class MySimplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(const Rect.fromLTWH(10, 10, 50, 50), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
