import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- avoid-passing-bloc-to-bloc ---

// BAD EXAMPLE
class CartBlocWithBlocDependency extends Bloc<CartEvent, CartState> {
  final AuthBloc authBloc;
  late final StreamSubscription _authSubscription;

  CartBlocWithBlocDependency(this.authBloc) : super(CartInitial()) {
    _authSubscription = authBloc.stream.listen((authState) {
      if (authState is AuthUnauthenticated) {
        add(ClearCart());
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}

// GOOD EXAMPLE
class CartPageWithListener extends StatelessWidget {
  const CartPageWithListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.read<CartBloc>().add(ClearCart());
        }
      },
      child: const CartView(),
    );
  }
}

class CartBlocWithStreamDependency extends Bloc<CartEvent, CartState> {
  final Stream<AuthStatus> _authStatusStream;

  CartBlocWithStreamDependency({required Stream<AuthStatus> authStatusStream})
    : _authStatusStream = authStatusStream,
      super(CartInitial()) {
    _authStatusStream.listen((status) {
      if (status == AuthStatus.unauthenticated) {
        add(ClearCart());
      }
    });
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

@immutable
sealed class CartEvent {}

@immutable
final class ClearCart extends CartEvent {}

@immutable
sealed class CartState {}

@immutable
final class CartInitial extends CartState {}

@immutable
sealed class AuthState {}

@immutable
final class AuthUnauthenticated extends AuthState {}

class AuthBloc extends Bloc<dynamic, AuthState> {
  AuthBloc() : super(AuthUnauthenticated());
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());
}

enum AuthStatus { authenticated, unauthenticated }

class CartView extends StatelessWidget {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}
