import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- avoid-empty-build-when ---

// BAD EXAMPLE
class BadBlocBuilder extends StatelessWidget {
  const BadBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return ExpensiveWidget(count: state);
      },
    );
  }
}

// GOOD EXAMPLE
class GoodBlocBuilder extends StatelessWidget {
  const GoodBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return ExpensiveWidget(count: state);
      },
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

class ExpensiveWidget extends StatelessWidget {
  final int count;
  const ExpensiveWidget({super.key, required this.count});

  @override
  Widget build(BuildContext context) => Text('$count');
}
