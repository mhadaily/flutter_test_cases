import 'package:flutter/material.dart';

/// --- prefer-immutable-bloc-events ---

// BAD EXAMPLE
@immutable
sealed class MutableUpdateUserEvent extends UserEvent {
  final String name;
  const MutableUpdateUserEvent(this.name) : super();
}

// GOOD EXAMPLE
@immutable
sealed class UserEvent {
  const UserEvent();
}

@immutable
final class ImmutableUpdateUserEvent extends UserEvent {
  final String name;
  const ImmutableUpdateUserEvent(this.name) : super();
}
