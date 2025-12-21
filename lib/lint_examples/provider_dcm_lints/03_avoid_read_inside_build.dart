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

// BAD EXAMPLE: read inside build -> no rebuilds on change
class CounterDisplayBad extends StatelessWidget {
  const CounterDisplayBad({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.read<Counter?>(); // watch: subscribes
    if (counter == null) {
      return const SizedBox.shrink();
    }
    return Text('Count: ${counter.value}');
  }
}

// GOOD EXAMPLE: watch inside build -> subscribes to changes
class CounterDisplayGood extends StatelessWidget {
  const CounterDisplayGood({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<Counter?>(); // watch: subscribes
    if (counter == null) {
      return const SizedBox.shrink();
    }
    return Text('Count: ${counter.value}');
  }
}

class CounterProviderApp extends StatelessWidget {
  const CounterProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: const Column(
        children: [CounterDisplayBad(), CounterDisplayGood()],
      ),
    );
  }
}
