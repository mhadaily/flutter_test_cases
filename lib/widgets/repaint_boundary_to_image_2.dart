import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawingPadScreen(),
    );
  }
}

class DrawingPadScreen extends StatefulWidget {
  const DrawingPadScreen({super.key});

  @override
  State<DrawingPadScreen> createState() => _DrawingPadScreenState();
}

class _DrawingPadScreenState extends State<DrawingPadScreen> {
  // 1. Create a GlobalKey to identify the RepaintBoundary.
  final GlobalKey _repaintKey = GlobalKey();

  // Store the drawing points.
  final List<Offset?> _points = [];

  // Store the captured image.
  ui.Image? _capturedImage;

  /// Captures the content of the RepaintBoundary as an image.
  Future<void> _captureDrawing() async {
    try {
      // 2. Find the RenderObject from the GlobalKey.
      final RenderRepaintBoundary boundary =
          _repaintKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      // 3. Convert the boundary to an image.
      // pixelRatio can be adjusted for higher or lower quality images.
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // Update the state to display the new image.
      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      // In a real application, you might show a SnackBar or a dialog.
      debugPrint("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing Pad'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => setState(() {
              _points.clear();
              _capturedImage = null; // Also clear the captured image
            }),
            tooltip: 'Clear Drawing',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Draw in the box below:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 4. Wrap the widget you want to capture with a RepaintBoundary.
            // Wrap the RepaintBoundary in an Expanded widget to prevent overflow.
            Expanded(
              child: RepaintBoundary(
                key: _repaintKey,
                child: AspectRatio(
                  aspectRatio: 1.0, // Ensures the drawing area remains square
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        _points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        _points.add(null); // Add a null to break the line
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      child: CustomPaint(
                        // Pass a copy of the _points list to ensure shouldRepaint correctly identifies changes
                        // as the list instance itself is modified, not replaced.
                        painter: DrawingPainter(
                          points: List<Offset?>.of(_points),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Drawing'),
              onPressed: _captureDrawing,
            ),
            const SizedBox(height: 20),
            const Text(
              'Captured Image:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 5. Display the captured image.
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                ),
                child: _capturedImage != null
                    ? RawImage(image: _capturedImage)
                    : const Center(
                        child: Text('Press capture to see the image here'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A CustomPainter to draw the lines.
class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) =>
      oldDelegate.points.length != points.length ||
      !listEquals<Offset?>(oldDelegate.points, points);

  // Helper function to compare lists
  bool listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    // Removed identical(a, b) check here as we are now passing a new list instance
    // to the painter on every repaint, ensuring direct element comparison.
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
