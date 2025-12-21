import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- avoid-instantiating-in-value-provider ---

class MyChangeNotifier extends ChangeNotifier {}

// BAD: Memory leak, nobody disposes this!
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      // 💥 MEMORY LEAK: This ChangeNotifier will never be disposed!
      value: MyChangeNotifier(),
      child: const HomePage(),
    );
  }
}

// GOOD: Provider manages the lifecycle
class MyAppGood extends StatelessWidget {
  const MyAppGood({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // ✅ Provider creates it, Provider disposes it
      create: (_) => MyChangeNotifier(),
      child: const HomePage(),
    );
  }
}

// GOOD: You manage the lifecycle
class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  late final MyChangeNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = MyChangeNotifier();
  }

  @override
  void dispose() {
    _notifier.dispose(); // ✅ You manage the lifecycle
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _notifier, // ✅ Existing instance
      child: const ChildWidget(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
