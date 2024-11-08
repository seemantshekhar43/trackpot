import 'package:flutter/material.dart';

import '../../domain/entities/user_preferences.dart';
import '../../domain/repository/user_preferences_repository.dart';
import '../datasources/user_preferences_local_datasource.dart';

class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  final UserPreferencesLocalDataSource localDataSource;

  UserPreferencesRepositoryImpl({required this.localDataSource});

  @override
  Future<UserPreferences> loadPreferences() async {
    final prefsMap = await localDataSource.loadPreferences();
    return UserPreferences(
      themeMode: _parseThemeMode(
          prefsMap[UserPreferencesLocalDataSourceImpl.THEME_KEY]),
      emailNotificationsEnabled:
          prefsMap[UserPreferencesLocalDataSourceImpl.EMAIL_NOTIFICATIONS_KEY],
    );
  }

  @override
  Future<void> savePreferences(UserPreferences preferences) async {
    await localDataSource.savePreferences({
      UserPreferencesLocalDataSourceImpl.THEME_KEY:
          preferences.themeMode.toString(),
      UserPreferencesLocalDataSourceImpl.EMAIL_NOTIFICATIONS_KEY:
          preferences.emailNotificationsEnabled,
    });
  }

  ThemeMode _parseThemeMode(String value) {
    print('value is: $value');
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }
}
