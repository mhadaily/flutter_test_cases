import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- avoid-existing-instances-in-bloc-provider ---

// BAD EXAMPLE
class MyAppBadProvider extends StatelessWidget {
  MyAppBadProvider({super.key});

  final CounterBloc counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => counterBloc, child: const CounterPage());
  }
}

// GOOD EXAMPLE
class MyAppGoodProvider extends StatelessWidget {
  const MyAppGoodProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const CounterPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);
}

@immutable
sealed class CounterEvent {}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}
