/*
BeveledRectangleBorder is a shape class in Flutter that creates a rectangular shape with its corners cut off at an angle, resulting in a beveled or chamfered appearance.

You would use it to give widgets a distinct, sharp-edged, or "cut-out" style instead of the usual rounded or squared corners. It's commonly applied to widgets like buttons, cards, and containers using their shape property.

Key Properties
borderRadius: This property takes a BorderRadius value and determines how far from the corner the bevel begins. A larger radius results in a larger, more dramatic cut-off corner.

side: This allows you to define a border (like a stroke) around the shape. You can set the color, width, and style of this border.
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
        appBar: AppBar(title: const Text('BeveledRectangleBorder Demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- Example 1: A Container with a Beveled Shape ---
              Container(
                width: 200,
                height: 150,
                decoration: const ShapeDecoration(
                  color: Colors.amber,
                  // Here is where the BeveledRectangleBorder is used.
                  shape: BeveledRectangleBorder(
                    // Defines the size of the corner cuts.
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    // Defines a 2-pixel wide black border around the shape.
                    side: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Beveled Container',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // --- Example 2: An ElevatedButton with a Beveled Shape ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  // The shape property of the button's style.
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                onPressed: () {},
                child: const Text('Beveled Button', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}