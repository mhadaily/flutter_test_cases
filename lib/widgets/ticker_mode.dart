/*
TickerMode is a widget that controls whether animations are running in a specific part of your app's widget tree.

By wrapping a widget with TickerMode, you can enable or disable all animations (like those driven by an AnimationController) for that widget and all of its descendants.

What It's For
Its main purpose is performance optimization and state management. Common use cases include:

Pausing Off-Screen Animations: If you have a PageView or a ListView with complex animations on each page, you can wrap each page in a TickerMode and disable it when it's not visible. This saves significant battery and CPU resources because the animations are truly paused, not just hidden.

Accessibility: Some users prefer to have animations disabled. You could wrap your entire app in a TickerMode and toggle it based on a user's preference.

Conditional Animation: Temporarily pausing all animations in a section of the UI while a specific event is happening, like waiting for a network response.
*/

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TickerModeExample(),
    );
  }
}

class TickerModeExample extends StatefulWidget {
  const TickerModeExample({super.key});

  @override
  State<TickerModeExample> createState() => _TickerModeExampleState();
}

class _TickerModeExampleState extends State<TickerModeExample> {
  // A boolean to control the TickerMode's `enabled` property.
  bool _animationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TickerMode Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // This Switch controls the TickerMode below.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _animationsEnabled ? 'Animations ON' : 'Animations OFF',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Switch(
                  value: _animationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _animationsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            
            // The TickerMode widget.
            // It will enable or disable animations for everything inside it.
            TickerMode(
              enabled: _animationsEnabled,
              child: const SpinningContainer(),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget with a continuous, repeating animation.
class SpinningContainer extends StatefulWidget {
  const SpinningContainer({super.key});

  @override
  State<SpinningContainer> createState() => _SpinningContainerState();
}

class _SpinningContainerState extends State<SpinningContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(); // The animation starts repeating immediately.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'I am animating!',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}