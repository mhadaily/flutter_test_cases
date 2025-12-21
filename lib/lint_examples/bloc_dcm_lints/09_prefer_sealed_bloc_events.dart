import 'package:flutter/material.dart';

/// --- prefer-sealed-bloc-events ---

// BAD EXAMPLE
@immutable
sealed class BadCounterEvent {}

@immutable
sealed class BadIncrementEvent extends BadCounterEvent {}

@immutable
sealed class BadDecrementEvent extends BadCounterEvent {}

void handleBadEvent(BadCounterEvent event) {
  if (event is BadIncrementEvent) {
    // handle
  } else if (event is BadDecrementEvent) {
    // handle
  }
}

// GOOD EXAMPLE
@immutable
sealed class GoodCounterEvent {}

@immutable
final class GoodIncrementEvent extends GoodCounterEvent {}

@immutable
final class GoodDecrementEvent extends GoodCounterEvent {}

void handleGoodEvent(GoodCounterEvent event) {
  switch (event) {
    case GoodIncrementEvent():
    // handle
    case GoodDecrementEvent():
    // handle
  }
}
