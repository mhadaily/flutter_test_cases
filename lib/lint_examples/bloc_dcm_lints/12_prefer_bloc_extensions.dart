import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- prefer-bloc-extensions ---

// BAD EXAMPLE
void badExtensions(BuildContext context) {
  final bloc = BlocProvider.of<CounterBloc>(context);
  final blocWithListen = BlocProvider.of<CounterBloc>(context, listen: true);
  debugPrint('$bloc $blocWithListen');
}

// GOOD EXAMPLE
void goodExtensions(BuildContext context) {
  final bloc = context.read<CounterBloc>();
  final blocWatched = context.watch<CounterBloc>();
  debugPrint('$bloc $blocWatched');
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

class CounterBloc extends Cubit<int> {
  CounterBloc() : super(0);
}
