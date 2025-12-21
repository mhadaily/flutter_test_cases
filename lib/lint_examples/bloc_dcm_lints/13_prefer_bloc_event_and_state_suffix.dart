import 'package:flutter/material.dart';

/// --- prefer-bloc-event-suffix & prefer-bloc-state-suffix ---

// BAD EXAMPLE
class FetchUsers {}

class UpdateProfile {}

class Loading {}

// GOOD EXAMPLE
@immutable
sealed class FetchUsersEvent {}

@immutable
sealed class UpdateProfileEvent {}

@immutable
sealed class LoadingState {}
