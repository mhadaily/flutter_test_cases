import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- prefer-provider-extensions ---

class UserModel extends ChangeNotifier {
  final String _name = 'User';
  String get name => _name;
}

// BAD: Verbose and easy to forget listen parameter
class ProviderOfBad extends StatelessWidget {
  const ProviderOfBad({super.key});

  void _handleTap(BuildContext context) {
    // Easy to forget listen: false when you need read
    final model = Provider.of<UserModel>(context, listen: false);
    // Use model for something
    debugPrint(model.name);
  }

  @override
  Widget build(BuildContext context) {
    // Have to remember listen: true is default (watch behavior)
    final model = Provider.of<UserModel>(context);

    return Column(
      children: [
        Text(model.name),
        ElevatedButton(
          onPressed: () => _handleTap(context),
          child: const Text('Tap'),
        ),
      ],
    );
  }
}

// GOOD: Clear intent, shorter code
class ExtensionMethodsGood extends StatelessWidget {
  const ExtensionMethodsGood({super.key});

  void _handleTap(BuildContext context) {
    // Read once (doesn't rebuild on changes)
    final model = context.read<UserModel?>();
    debugPrint(model?.name ?? 'No Model');
  }

  @override
  Widget build(BuildContext context) {
    // Watch (rebuilds when value changes)
    final model = context.watch<UserModel?>();

    // Select a specific part
    final name = context.select<UserModel?, String?>((UserModel? m) => m?.name);

    return Column(
      children: [
        Text(model?.name ?? 'No Model'),
        Text(name ?? 'Unknown'),
        ElevatedButton(
          onPressed: () => _handleTap(context),
          child: const Text('Tap'),
        ),
      ],
    );
  }
}

class ProviderExtensionsApp extends StatelessWidget {
  const ProviderExtensionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserModel(),
      child: const Column(children: [ProviderOfBad(), ExtensionMethodsGood()]),
    );
  }
}
