import 'package:flutter/material.dart';

class OrientationWidget extends StatelessWidget {
  const OrientationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return const Row(children: []); // Wide layout
        } else {
          return const Column(children: []); // Narrow layout
        }
      },
    );
  }
}
