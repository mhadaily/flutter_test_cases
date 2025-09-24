/*
RepaintBoundary is a widget that isolates its subtree into its own render layer.

Its render object (RenderRepaintBoundary) has a method toImage() that lets you capture that layer as a ui.Image.

That image can then be converted to bytes (PNG, JPEG, etc.), saved to disk, uploaded, or displayed elsewhere.
*/


import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CaptureExample(),
  ));
}

class CaptureExample extends StatefulWidget {
  @override
  _CaptureExampleState createState() => _CaptureExampleState();
}

class _CaptureExampleState extends State<CaptureExample> {
  final GlobalKey _boundaryKey = GlobalKey();
  Uint8List? _capturedImage;

  Future<void> _capturePng() async {
    try {
      // 1. Get the RenderRepaintBoundary from the key
      RenderRepaintBoundary boundary = _boundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // 2. Convert it to a ui.Image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // 3. Convert the ui.Image to PNG bytes
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      setState(() {
        _capturedImage = pngBytes;
      });
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RepaintBoundary Capture Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // This is the widget we want to capture
          RepaintBoundary(
            key: _boundaryKey,
            child: Container(
              color: Colors.blueAccent,
              width: 200,
              height: 200,
              child: const Center(
                child: Text(
                  'Snapshot me!',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _capturePng,
            child: const Text('Capture to Image'),
          ),

          const SizedBox(height: 20),

          // Show the captured image if available
          if (_capturedImage != null)
            Image.memory(_capturedImage!, width: 200),
        ],
      ),
    );
  }
}
