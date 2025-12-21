import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- prefer-provider-extensions ---

class Counter extends ChangeNotifier {
  int value = 0;
  void increment() {
    value++;
    notifyListeners();
  }
}

class ReadBad extends StatelessWidget {
  const ReadBad({super.key});

  @override
  Widget build(BuildContext context) {
    // BAD: using Provider.of with listen: false instead of read extension
    final counter = Provider.of<Counter>(context, listen: false);
    return ElevatedButton(
      onPressed: counter.increment,
      child: const Text('Increment'),
    );
  }
}

class ReadGood extends StatelessWidget {
  const ReadGood({super.key});

  @override
  Widget build(BuildContext context) {
    // GOOD: context.read extension is clearer
    return ElevatedButton(
      onPressed: () => context.read<Counter?>()?.increment(),
      child: const Text('Increment'),
    );
  }
}

class WatchGood extends StatelessWidget {
  const WatchGood({super.key});

  @override
  Widget build(BuildContext context) {
    // GOOD: context.watch extension subscribes to changes
    final value = context.watch<Counter?>()?.value ?? 0;
    return Text('Value: $value');
  }
}

class ProviderExtensionsApp extends StatelessWidget {
  const ProviderExtensionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: const Column(children: [ReadBad(), ReadGood(), WatchGood()]),
    );
  }
}
