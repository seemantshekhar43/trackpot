import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/preferences/domain/entities/user_preferences.dart';
import '../../features/preferences/domain/repository/user_preferences_repository.dart';

class UserPreferencesCubit extends Cubit<UserPreferences> {
  final UserPreferencesRepository repository;

  UserPreferencesCubit({required this.repository})
      : super(const UserPreferences(
          themeMode: ThemeMode.system,
          emailNotificationsEnabled: true,
        ));

  Future<void> loadPreferences() async {
    final preferences = await repository.loadPreferences();
    print('preferences loaded');
    emit(preferences);
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final newPreferences = UserPreferences(
      themeMode: themeMode,
      emailNotificationsEnabled: state.emailNotificationsEnabled,
    );
    await repository.savePreferences(newPreferences);
    emit(newPreferences);
  }

  Future<void> updateEmailNotifications(bool enabled) async {
    final newPreferences = UserPreferences(
      themeMode: state.themeMode,
      emailNotificationsEnabled: enabled,
    );
    await repository.savePreferences(newPreferences);
    emit(newPreferences);
  }
}
