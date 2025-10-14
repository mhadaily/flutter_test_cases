/*
BlockSemantics is a Flutter widget used to control how accessibility tools, like screen readers (e.g., TalkBack on Android or VoiceOver on iOS), perceive a group of widgets. Its primary function is to prevent screen readers from accessing the individual widgets within its child tree, effectively making them invisible to accessibility services.

Think of it like putting a "Do Not Disturb" sign on a group of widgets. A screen reader will see the sign and ignore everything behind it, preventing it from reading out potentially confusing or redundant information.

When to Use It 🧐
The most common use case for BlockSemantics is to hide widgets that are visually behind another widget but might still be accessible to screen readers. A classic example is a modal dialog or an overlay.

When a dialog box appears, you want the user to focus only on the dialog's content. However, the widgets on the page behind the dialog are still part of the widget tree. Without BlockSemantics, a screen reader user could accidentally swipe past the dialog and start interacting with the hidden UI behind it, which is a confusing and poor user experience.

By wrapping the background content in a BlockSemantics widget when the dialog is open, you ensure the screen reader's focus is trapped within the dialog, as it can no longer see the widgets behind it.
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlockSemanticsExample(),
    );
  }
}

class BlockSemanticsExample extends StatefulWidget {
  const BlockSemanticsExample({super.key});

  @override
  State<BlockSemanticsExample> createState() => _BlockSemanticsExampleState();
}

class _BlockSemanticsExampleState extends State<BlockSemanticsExample> {
  // A state variable to track if the dialog is currently shown.
  bool _isDialogShowing = false;

  void _showContentDialog() {
    setState(() {
      _isDialogShowing = true;
    });

    // Show a dialog. When it's dismissed, update the state.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Important Message'),
        content: const Text('This is the content of the dialog.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    ).then((_) {
      // This `then` block executes after the dialog is closed.
      setState(() {
        _isDialogShowing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BlockSemantics Demo')),
      // The BlockSemantics widget wraps the main content of the page.
      body: BlockSemantics(
        // The `blocking` property controls whether the semantics are blocked.
        // We block the UI when the dialog is showing.
        blocking: _isDialogShowing,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This is the background content.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showContentDialog,
                child: const Text('Show Dialog'),
              ),
              const SizedBox(height: 20),
              // This slider is part of the background content.
              // Without BlockSemantics, a screen reader could access it
              // even when the dialog is open.
              Slider(
                value: 0.5,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}