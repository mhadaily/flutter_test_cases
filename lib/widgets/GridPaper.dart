/*
GridPaper is a debugging widget in Flutter that helps you visually align your UI elements. It overlays a grid pattern onto its child widget, making it easier to check for misalignments and ensure your layout is pixel-perfect.

Think of it as placing a sheet of graph paper over your app. It's purely a visual aid for development and is not meant to be used in production UI.

Key Properties
color: The color of the grid lines.

divisions: The number of major grid lines.

subdivisions: The number of smaller lines within each major grid division.

interval: The distance in logical pixels between the major grid lines.
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GridPaper Demo'),
        ),
        body: Center(
          // The GridPaper widget overlays a grid on its child.
          child: GridPaper(
            // Color of the grid lines.
            color: Colors.red,
            // The distance between the main grid lines.
            interval: 100,
            // The number of major divisions.
            divisions: 2,
            // The number of subdivisions within each major division.
            subdivisions: 4,
            child: SizedBox(
              width: 300,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(size: 80),
                  const SizedBox(height: 20),
                  const Text(
                    'Align Me!',
                    style: TextStyle(fontSize: 24),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Use the grid to check if I am perfectly centered.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}