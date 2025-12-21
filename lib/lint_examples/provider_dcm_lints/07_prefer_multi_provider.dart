import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- prefer-multi-provider ---

class AuthService {}

class ApiClient {}

class UserModel extends ChangeNotifier {}

class SettingsModel extends ChangeNotifier {}

// BAD: Nesting hell
class NestedProvidersBad extends StatelessWidget {
  const NestedProvidersBad({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => AuthService(),
      child: Provider<ApiClient>(
        create: (_) => ApiClient(),
        child: ChangeNotifierProvider<UserModel>(
          create: (_) => UserModel(),
          child: ChangeNotifierProvider<SettingsModel>(
            create: (_) => SettingsModel(),
            child: const MyApp(), // 4 levels deep!
          ),
        ),
      ),
    );
  }
}

// GOOD: Flat and readable
class MultiProviderGood extends StatelessWidget {
  const MultiProviderGood({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<ApiClient>(create: (_) => ApiClient()),
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
        ChangeNotifierProvider<SettingsModel>(create: (_) => SettingsModel()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
