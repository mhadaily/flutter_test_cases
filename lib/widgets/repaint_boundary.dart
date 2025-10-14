/*
The RepaintBoundary widget's purpose is to limit the area of the screen that needs to be redrawn when visual updates occur by reducing unnecessary repaints, which drastically improves an app's performance, especially in scenarios with complex or frequently changing UI elements.

The RepaintBoundary widget works by creating a new compositing layer in Flutter’s rendering pipeline. Layers are an essential part of Flutter’s rendering model, allowing portions of the scene to be drawn independently. I talked about rendering pipe in Flutter quite extensively in my book FlutterEngineering.io.

When a RepaintBoundary is added to a widget, that widget and its subtree are isolated into their own compositing layer. This ensures that only that layer needs to be redrawn when a visual update happens within the subtree, not the entire screen.

Without it, Flutter’s rendering engine propagates visual updates upward through the widget tree, marking all ancestor widgets as dirty. This cascading effect can result in large portions of the screen being unnecessarily redrawn, even if the change is confined to a small area.

The RepaintBoundary is implemented at the rendering layer as a RenderRepaintBoundary object. This class overrides the paint method to control how the widget is drawn and when it needs to be repainted:
*/

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Required for the debug rainbow
import 'dart:math' as math;

void main() {
  // Enable this to see the repaint boundaries!
  debugRepaintRainbowEnabled = true;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepaintBoundaryDemo(),
    );
  }
}

class RepaintBoundaryDemo extends StatefulWidget {
  const RepaintBoundaryDemo({super.key});

  @override
  State<RepaintBoundaryDemo> createState() => _RepaintBoundaryDemoState();
}

class _RepaintBoundaryDemoState extends State<RepaintBoundaryDemo> 
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RepaintBoundary Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- WITHOUT RepaintBoundary ---
            // The spinning box will repaint every time the counter changes.
            const Text(
              'Without RepaintBoundary', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
            const Text('The animation repaints when the counter changes.'),
            const SizedBox(height: 10),
            SpinningBox(controller: _controller),
            
            const SizedBox(height: 50),
            const Divider(thickness: 2),
            const SizedBox(height: 50),

            // --- WITH RepaintBoundary ---
            // The boundary isolates the animation, so it only repaints itself.
            const Text(
              'With RepaintBoundary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
            const Text('The animation is isolated and does not repaint.'),
            const SizedBox(height: 10),
            RepaintBoundary(
              child: SpinningBox(controller: _controller),
            ),
            
            const SizedBox(height: 40),
            Text('Counter: $_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// A simple spinning box widget
class SpinningBox extends StatelessWidget {
  final AnimationController controller;

  const SpinningBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.value * 2 * math.pi,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.deepPurple,
            child: const Center(
              child: Text('Whee!', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
  }
}