import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// --- avoid-passing-build-context-to-blocs ---

// BAD EXAMPLE
@immutable
sealed class LoadUserEventWithContext extends UserEvent {
  final BuildContext context;
  LoadUserEventWithContext(this.context);
}

class SettingsCubitWithContext extends Cubit<SettingsState> {
  SettingsCubitWithContext() : super(SettingsInitial());

  void loadTheme(BuildContext context) async {
    final theme = Theme.of(context);
    emit(SettingsLoaded(theme.brightness.toString()));
  }
}

// GOOD EXAMPLE
@immutable
sealed class LoadUserEventWithData extends UserEvent {
  final String userId;
  LoadUserEventWithData(this.userId);
}

class SettingsCubitWithRepository extends Cubit<SettingsState> {
  final ThemeRepository _themeRepository;
  SettingsCubitWithRepository(this._themeRepository) : super(SettingsInitial());

  void loadTheme() async {
    final theme = await _themeRepository.getCurrentTheme();
    emit(SettingsLoaded(theme));
  }
}

// ---------------------------------------------------------------------------
// Supporting types
// ---------------------------------------------------------------------------

@immutable
sealed class UserEvent {}

@immutable
sealed class SettingsState {}

@immutable
final class SettingsInitial extends SettingsState {}

@immutable
final class SettingsLoaded extends SettingsState {
  final String theme;
  SettingsLoaded(this.theme);
}

class ThemeRepository {
  Future<String> getCurrentTheme() async => 'light';
}
