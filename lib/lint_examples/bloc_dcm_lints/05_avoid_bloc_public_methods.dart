import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- avoid-bloc-public-methods ---

// BAD EXAMPLE
class CounterBlocWithPublicMethod extends Bloc<CounterEvent, int> {
  CounterBlocWithPublicMethod() : super(0);

  void incrementDirectly() {
    emit(state + 1);
  }
}

// GOOD EXAMPLE
class CounterBlocWithPrivateMethod extends Bloc<CounterEvent, int> {
  CounterBlocWithPrivateMethod() : super(0) {
    on<IncrementPressed>((event, emit) => emit(state + 1));
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

@immutable
sealed class CounterEvent {}

@immutable
final class IncrementPressed extends CounterEvent {}

void useCounterBloc(BuildContext context) {
  context.read<CounterBlocWithPrivateMethod>().add(IncrementPressed());
}
