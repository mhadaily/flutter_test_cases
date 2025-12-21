import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- avoid-instantiating-in-bloc-value-provider ---

// BAD EXAMPLE
class BadValueProviderWidget extends StatelessWidget {
  const BadValueProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: CounterBloc(), child: const CounterPage());
  }
}

// GOOD EXAMPLE
class GoodValueProviderWidget extends StatefulWidget {
  const GoodValueProviderWidget({super.key});

  @override
  State<GoodValueProviderWidget> createState() =>
      _GoodValueProviderWidgetState();
}

class _GoodValueProviderWidgetState extends State<GoodValueProviderWidget> {
  late final CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _counterBloc, child: const CounterPage());
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
