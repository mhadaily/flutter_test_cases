/*
You're right. Let's refine that with a clearer explanation, a practical use case, and heavily commented code.

What is LayerLink? (A Simple Analogy)
Imagine you have a moving car (your target widget, like a button) and you want to place a sticky note (your follower widget, like a dropdown menu) right above it.

If you just place the sticky note on the screen, it won't move when the car moves.

A LayerLink is like an invisible, rigid wire. You attach one end to the car and the other end to the sticky note. Now, no matter where the car moves on the screen, the sticky note will always stay perfectly positioned relative to it.

LayerLink connects two widgets:

CompositedTransformTarget: The "car" – the widget you want to anchor to.

CompositedTransformFollower: The "sticky note" – the widget that appears and follows the target.

When to Use It (A Common Use Case)
The most common use case is for displaying overlay widgets that need to be anchored to a specific UI element. Think of things like:

Dropdown Menus: When you tap a button, the menu of options must appear directly below or above that specific button.

Custom Tooltips: When a user long-presses an icon, a custom-styled tooltip appears next to it.

Text Selection Handles: The little teardrop handles that appear below selected text must follow the text as you scroll.

In all these cases, the follower widget (the menu, tooltip, or handle) is often rendered on the Overlay—a separate layer that floats on top of your entire app's UI—while the LayerLink ensures it's positioned correctly relative to the original widget.
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
      home: LayerLinkDropdownExample(),
    );
  }
}

class LayerLinkDropdownExample extends StatefulWidget {
  const LayerLinkDropdownExample({super.key});

  @override
  State<LayerLinkDropdownExample> createState() => _LayerLinkDropdownExampleState();
}

class _LayerLinkDropdownExampleState extends State<LayerLinkDropdownExample> {
  // STEP 1: Create the LayerLink.
  // This is the "invisible wire" that will connect our button and the dropdown menu.
  final LayerLink _layerLink = LayerLink();

  // We need to manage the state of our dropdown menu.
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  /// Toggles the dropdown menu's visibility.
  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _hideDropdown();
    } else {
      _showDropdown();
    }
  }

  /// Shows the dropdown menu.
  void _showDropdown() {
    // Create the OverlayEntry, which is the widget that will be displayed.
    _overlayEntry = _createDropdownEntry();
    // Insert the entry into the Overlay, making it visible.
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  /// Hides the dropdown menu.
  void _hideDropdown() {
    // Remove the entry from the Overlay, hiding it.
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  /// Creates the widget that will be displayed in the overlay.
  OverlayEntry _createDropdownEntry() {
    return OverlayEntry(
      builder: (context) {
        // STEP 3: Create the Follower.
        // This widget "follows" the Target using the same LayerLink.
        return CompositedTransformFollower(
          // The link that connects this follower to the target.
          link: _layerLink,
          // We don't want the follower to appear until the target is laid out.
          showWhenUnlinked: false,
          // Aligns the top-left of the follower with the bottom-left of the target.
          targetAnchor: Alignment.bottomLeft,
          // Adjusts the follower's position. Here, we move it down by 8 pixels.
          offset: const Offset(0, 8),
          // The actual widget we want to display as the dropdown.
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Option 1'),
                  Divider(),
                  Text('Option 2'),
                  Divider(),
                  Text('Logout'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropdown Menu with LayerLink')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Press the button to show a menu that is perfectly aligned using LayerLink.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // STEP 2: Create the Target.
            // This is the widget our dropdown will be anchored to.
            CompositedTransformTarget(
              // The link that this target provides for a follower to use.
              link: _layerLink,
              child: ElevatedButton(
                onPressed: _toggleDropdown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Menu'),
                    Icon(
                      _isDropdownOpen
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}