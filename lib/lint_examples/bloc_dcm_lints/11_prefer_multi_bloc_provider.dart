import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- prefer-multi-bloc-provider ---

// BAD EXAMPLE
class BadNestedProviders extends StatelessWidget {
  const BadNestedProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(),
        child: BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
          child: const MyApp(),
        ),
      ),
    );
  }
}

// GOOD EXAMPLE
class GoodMultiProvider extends StatelessWidget {
  const GoodMultiProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<SettingsBloc>(create: (context) => SettingsBloc()),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      ],
      child: const MyApp(),
    );
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

class AuthBloc extends Cubit<int> {
  AuthBloc() : super(0);
}

class SettingsBloc extends Cubit<int> {
  SettingsBloc() : super(0);
}

class ThemeBloc extends Cubit<int> {
  ThemeBloc() : super(0);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}
