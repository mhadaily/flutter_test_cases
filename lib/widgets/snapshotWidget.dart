import 'package:flutter/material.dart';

/*
SnapshotWidget is a performance optimization tool in Flutter. It's designed to take a complex, "expensive-to-draw" widget and convert it into a static, non-interactive image.
Think of it like taking a screenshot of a specific widget. Once the screenshot is taken, Flutter no longer needs to spend resources redrawing the original complex widget on every frame; it just redraws the simple, cheap image.

Key Concepts
  When to Use It: You should use SnapshotWidget when you have a part of your UI that is graphically complex (e.g., a custom drawing, a chart, or a complicated stack of widgets) but does not change frequently.

How It Works:

    You wrap your expensive widget with a SnapshotWidget.

    You provide a SnapshotController.

    Initially, controller.allowSnapshotting is false, and the original widget is drawn normally.

    When you are ready (e.g., an animation finishes or initial data is loaded), you set controller.allowSnapshotting = true.

    On the next frame, SnapshotWidget paints the child into a rasterized image buffer (the "snapshot") and then displays that image from then on. The original child widget is no longer painted, saving performance.

Important Limitation: The snapshot is not interactive. Any gesture detectors, buttons, or animations within the original widget will no longer work after the snapshot is taken.
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnapshotExample(),
    );
  }
}

class SnapshotExample extends StatefulWidget {
  const SnapshotExample({super.key});

  @override
  State<SnapshotExample> createState() => _SnapshotExampleState();
}

class _SnapshotExampleState extends State<SnapshotExample> {
  // The controller to enable/disable snapshotting
  final controller = SnapshotController();
  bool isSnapshotEnabled = false;
  int buildCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SnapshotWidget Demo (Builds: $buildCounter)'),
        actions: [
          // A button to increment a counter, proving the parent is rebuilding
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => buildCounter++),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The widget that will be snapshotted
            SnapshotWidget(
              controller: controller,
              child: const ExpensiveCircleGrid(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Toggle the snapshotting state
                setState(() {
                  isSnapshotEnabled = !isSnapshotEnabled;
                  controller.allowSnapshotting = isSnapshotEnabled;
                });
              },
              child: Text(
                isSnapshotEnabled
                    ? 'Unfreeze Widget'
                    : 'Freeze Widget (Snapshot)',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isSnapshotEnabled
                  ? 'The widget is now a static image.\nParent rebuilds will not repaint it.'
                  : 'The widget is live and will repaint.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that is intentionally expensive to draw.
class ExpensiveCircleGrid extends StatelessWidget {
  const ExpensiveCircleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Print statement to see when this widget's build method is called
    print("--- Repainting ExpensiveCircleGrid ---");
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: CustomPaint(painter: CirclePainter()),
    );
  }
}

/// The CustomPainter that draws the grid of circles.
class CirclePainter extends CustomPainter {
  // A static variable belongs to the class itself, not an instance.
  // This ensures our counter doesn't reset every time the widget rebuilds.
  static int _paintCount = 0;

  @override
  void paint(Canvas canvas, Size size) {
    // Increment the counter and print it
    _paintCount++;
    print("🎨 CirclePainter is painting now! (Count: $_paintCount) 🎨");

    final paint = Paint()..color = Colors.teal;
    double radius = 5.0;
    // Draw a grid of 20x20 circles
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        canvas.drawCircle(
          Offset(i * 10.0 + radius, j * 10.0 + radius),
          radius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
