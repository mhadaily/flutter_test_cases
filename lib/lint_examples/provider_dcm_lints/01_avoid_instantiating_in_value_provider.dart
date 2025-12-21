import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- avoid-instantiating-in-value-provider ---

// BAD EXAMPLE
class BadValueConstructorApp extends StatelessWidget {
  const BadValueConstructorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      // 💥 New instance each rebuild, never disposed
      value: Counter(),
      child: const CounterScreen(),
    );
  }
}

// GOOD EXAMPLE: Provider owns lifecycle when using create:
class GoodCreateConstructorApp extends StatelessWidget {
  const GoodCreateConstructorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: const CounterScreen(),
    );
  }
}

// GOOD EXAMPLE: Using .value with a managed instance you dispose yourself
class GoodManagedValueApp extends StatefulWidget {
  const GoodManagedValueApp({super.key});

  @override
  State<GoodManagedValueApp> createState() => _GoodManagedValueAppState();
}

class _GoodManagedValueAppState extends State<GoodManagedValueApp> {
  late final Counter _counter;

  @override
  void initState() {
    super.initState();
    _counter = Counter();
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _counter,
      child: const CounterScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

class Counter extends ChangeNotifier {
  int value = 0;

  void increment() {
    value++;
    notifyListeners();
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<Counter?>();

    if (counter == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        Text('Count: ${counter.value}'),
        ElevatedButton(
          onPressed: counter.increment,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
