import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- prefer-multi-provider ---

class Cart extends ChangeNotifier {}

class Catalog extends ChangeNotifier {}

class SingleProvidersBad extends StatelessWidget {
  const SingleProvidersBad({super.key});

  @override
  Widget build(BuildContext context) {
    // BAD: multiple nested providers instead of MultiProvider
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: ChangeNotifierProvider(
        create: (_) => Catalog(),
        child: const Text('Store'),
      ),
    );
  }
}

class MultiProviderGood extends StatelessWidget {
  const MultiProviderGood({super.key});

  @override
  Widget build(BuildContext context) {
    // GOOD: MultiProvider groups providers neatly
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Catalog()),
      ],
      child: const Text('Store'),
    );
  }
}
