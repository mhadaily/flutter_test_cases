import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- avoid-read-inside-build ---

class Counter extends ChangeNotifier {
  int value = 0;
  void increment() {
    value++;
    notifyListeners();
  }
}

// BAD: Widget won't update when counter changes!
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // 💥 Using read inside build — no subscription!
    final counter = context.read<Counter?>();

    return Text('Count: ${counter?.value ?? 0}');
  }
}

// GOOD: Widget updates when counter changes
class CounterDisplayGood extends StatelessWidget {
  const CounterDisplayGood({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Using watch inside build — subscribed to changes!
    final counter = context.watch<Counter?>();

    return Text('Count: ${counter?.value ?? 0}');
  }
}

class CounterProviderApp extends StatelessWidget {
  const CounterProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: const Column(children: [CounterDisplay(), CounterDisplayGood()]),
    );
  }
}
