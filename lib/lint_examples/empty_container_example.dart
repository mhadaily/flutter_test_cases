// Example file demonstrating the empty_container rule
//
// This rule detects empty Container widgets that have no visual effect.
// Empty containers should be removed or given child widgets.

import 'package:flutter/material.dart';

class EmptyContainerExamples extends StatelessWidget {
  const EmptyContainerExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // This will trigger the empty_container warning
        Container(),

        // Another empty container
        Container(),

        // Correct usage - Container with child (will NOT trigger warning)
        Container(child: const Text('Hello')),

        // Correct usage - Container with decoration (will NOT trigger warning)
        Container(color: Colors.blue),

        // Correct usage - Container with width/height (will NOT trigger warning)
        Container(width: 100, height: 100),

        // Correct usage - Container with padding (will NOT trigger warning)
        Container(padding: const EdgeInsets.all(8)),
      ],
    );
  }
}

class AnotherExample extends StatelessWidget {
  const AnotherExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Empty container in a different context
    return Container();
  }
}

Widget buildEmptyWidget() {
  // This will also be flagged
  return Container();
}

Widget buildCorrectWidget() {
  // This is correct - has a child
  return Container(child: const Icon(Icons.star));
}
