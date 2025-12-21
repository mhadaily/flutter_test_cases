import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- prefer-nullable-provider-types ---

class UserModel extends ChangeNotifier {
  UserModel(this.name);
  final String name;
}

final sharedUser = UserModel('Alice'); // existing instance for value provider

class ReusableWidgetBad extends StatelessWidget {
  const ReusableWidgetBad({super.key});

  @override
  Widget build(BuildContext context) {
    // BAD: crashes if UserModel is not provided above
    final model = context.watch<UserModel>();
    return Text(model.name);
  }
}

class ReusableWidgetGood extends StatelessWidget {
  const ReusableWidgetGood({super.key});

  @override
  Widget build(BuildContext context) {
    // GOOD: handles missing provider safely
    final model = context.watch<UserModel?>();
    if (model == null) return const Text('No user');
    return Text(model.name);
  }
}

class NullableProviderApp extends StatelessWidget {
  const NullableProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BAD: non-nullable provider; using widget elsewhere will throw
        Provider<UserModel>.value(
          value: sharedUser,
          child: const ReusableWidgetBad(),
        ),
        // GOOD: nullable provider; widget handles missing provider
        Provider<UserModel?>.value(
          value: null,
          child: const ReusableWidgetGood(),
        ),
      ],
    );
  }
}
