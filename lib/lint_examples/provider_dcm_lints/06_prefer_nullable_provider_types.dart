import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- prefer-nullable-provider-types ---

class UserModel extends ChangeNotifier {
  UserModel(this.name);
  final String name;
}

// BAD: Crashes if provider is missing
class ReusableWidget extends StatelessWidget {
  const ReusableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 💥 Throws ProviderNotFoundException if used outside provider scope!
    final model = context.watch<UserModel>();

    return Text(model.name);
  }
}

// GOOD: Handles missing provider gracefully
class ReusableWidgetGood extends StatelessWidget {
  const ReusableWidgetGood({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Returns null if provider is missing
    final model = context.watch<UserModel?>();

    if (model == null) {
      return const Text('No user');
    }

    return Text(model.name);
  }
}

class NullableProviderApp extends StatelessWidget {
  const NullableProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Demonstrate the bad pattern - using non-nullable in provider scope
        Provider<UserModel>(
          create: (_) => UserModel('Alice'),
          child: const ReusableWidget(),
        ),
        // Demonstrate the good pattern - nullable provider
        Provider<UserModel?>(
          create: (_) => null,
          child: const ReusableWidgetGood(),
        ),
      ],
    );
  }
}
