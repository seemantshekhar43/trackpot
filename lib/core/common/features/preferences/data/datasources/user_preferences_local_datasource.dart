import 'package:shared_preferences/shared_preferences.dart';

abstract class UserPreferencesLocalDataSource {
  Future<Map<String, dynamic>> loadPreferences();
  Future<void> savePreferences(Map<String, dynamic> preferences);
}

class UserPreferencesLocalDataSourceImpl
    implements UserPreferencesLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String THEME_KEY = 'theme_mode';
  static const String EMAIL_NOTIFICATIONS_KEY = 'email_notifications';

  UserPreferencesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Map<String, dynamic>> loadPreferences() async {
    return {
      THEME_KEY: sharedPreferences.getString(THEME_KEY) ?? 'system',
      EMAIL_NOTIFICATIONS_KEY:
          sharedPreferences.getBool(EMAIL_NOTIFICATIONS_KEY) ?? true,
    };
  }

  @override
  Future<void> savePreferences(Map<String, dynamic> preferences) async {
    await sharedPreferences.setString(THEME_KEY, preferences[THEME_KEY]);
    await sharedPreferences.setBool(
        EMAIL_NOTIFICATIONS_KEY, preferences[EMAIL_NOTIFICATIONS_KEY]);
  }
}
