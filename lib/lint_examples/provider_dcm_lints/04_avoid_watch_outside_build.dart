import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- avoid-watch-outside-build ---

class ThemeController extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class ToggleButtonBad extends StatefulWidget {
  const ToggleButtonBad({super.key});

  @override
  State<ToggleButtonBad> createState() => _ToggleButtonBadState();
}

class _ToggleButtonBadState extends State<ToggleButtonBad> {
  // BAD: watch used in initState (outside build)
  @override
  void initState() {
    super.initState();
    context.watch<ThemeController>(); // lint: watch only inside build
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<ThemeController?>()?.toggle(),
      child: const Text('Toggle'),
    );
  }
}

class ToggleButtonGood extends StatelessWidget {
  const ToggleButtonGood({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ThemeController?>();
    final isDark = controller?.isDark ?? false; // OK: inside build
    return ElevatedButton(
      onPressed: () => context.read<ThemeController?>()?.toggle(),
      child: Text(isDark ? 'Dark' : 'Light'),
    );
  }
}

class ThemeProviderApp extends StatelessWidget {
  const ThemeProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const Column(children: [ToggleButtonBad(), ToggleButtonGood()]),
    );
  }
}
