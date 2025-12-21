import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- emit-new-bloc-state-instances ---

// BAD EXAMPLE
class UserBlocBad extends Bloc<UserBadEvent, UserMutableState> {
  UserBlocBad() : super(UserMutableState(name: '')) {
    on<UpdateNameEventBad>((event, emit) {
      // state.name = event.name;
      emit(state);
    });
  }
}

// GOOD EXAMPLE
class UserBlocGood extends Bloc<UserGoodEvent, UserState> {
  UserBlocGood() : super(const UserState(name: '')) {
    on<UpdateNameEventGood>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

@immutable
sealed class UserBadEvent {}

@immutable
final class UpdateNameEventBad extends UserBadEvent {
  final String name;
  UpdateNameEventBad(this.name);
}

@immutable
final class UserMutableState {
  final String name;
  const UserMutableState({required this.name});
}

@immutable
sealed class UserGoodEvent {
  const UserGoodEvent();
}

@immutable
final class UpdateNameEventGood extends UserGoodEvent {
  final String name;
  const UpdateNameEventGood(this.name);
}

@immutable
final class UserState {
  final String name;
  const UserState({required this.name});
  UserState copyWith({String? name}) => UserState(name: name ?? this.name);
}
