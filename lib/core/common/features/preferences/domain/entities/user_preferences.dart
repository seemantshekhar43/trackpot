import 'package:flutter/material.dart';

class UserPreferences {
  final ThemeMode themeMode;
  final bool emailNotificationsEnabled;
  // Add other preferences as needed

  const UserPreferences({
    required this.themeMode,
    required this.emailNotificationsEnabled,
  });
}