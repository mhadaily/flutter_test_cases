import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- check-is-not-closed-after-async-gap ---

// BAD EXAMPLE
class SearchBlocBad extends Bloc<SearchEvent, SearchState> {
  SearchBlocBad(this._repository) : super(SearchInitialImpl()) {
    on<SearchQueryChanged>(_onQueryChanged);
  }

  final SearchRepository _repository;

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    final results = await _repository.search(event.query);
    // 💥 CRASH: If user navigated away during the search, this emit throws
    emit(SearchSuccessImpl(results));
  }
}

// GOOD EXAMPLE
class SearchBlocGood extends Bloc<SearchEvent, SearchState> {
  SearchBlocGood(this._repository) : super(SearchInitialImpl()) {
    on<SearchQueryChanged>(_onQueryChanged);
  }

  final SearchRepository _repository;

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    final results = await _repository.search(event.query);
    // ✅ Safe: Check before emitting
    if (!isClosed) {
      emit(SearchSuccessImpl(results));
    }
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

@immutable
sealed class SearchEvent {}

@immutable
sealed class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}

@immutable
final class SearchState {}

@immutable
sealed class SearchInitial extends SearchState {}

@immutable
final class SearchInitialImpl extends SearchInitial {}

@immutable
sealed class SearchLoading extends SearchState {}

@immutable
final class SearchLoadingState extends SearchState {}

@immutable
sealed class SearchSuccess extends SearchState {
  final List<String> results;
  SearchSuccess(this.results);
}

@immutable
final class SearchSuccessImpl extends SearchSuccess {
  SearchSuccessImpl(super.results);
}

class SearchRepository {
  Future<List<String>> search(String query) async => <String>[];
}
