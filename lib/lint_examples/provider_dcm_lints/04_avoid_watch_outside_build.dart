import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- avoid-watch-outside-build ---

class Counter extends ChangeNotifier {
  int value = 0;
  void increment() {
    value++;
    notifyListeners();
  }
}

// BAD: Subscribing where it doesn't make sense
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _handleTap(BuildContext context) {
    // 💥 Using watch outside build — wasteful and potentially buggy!
    final counter = context.watch<Counter?>();
    counter?.increment();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleTap(context),
      child: const Text('Increment'),
    );
  }
}

// GOOD: Read for event handlers
class MyHomePageGood extends StatelessWidget {
  const MyHomePageGood({super.key});

  void _handleTap(BuildContext context) {
    // ✅ Using read in callback — no unnecessary subscription
    final counter = context.read<Counter?>();
    counter?.increment();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleTap(context),
      child: const Text('Increment'),
    );
  }
}

class CounterProviderApp extends StatelessWidget {
  const CounterProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: const Column(children: [MyHomePage(), MyHomePageGood()]),
    );
  }
}
