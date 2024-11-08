
import '../entities/user_preferences.dart';

abstract class UserPreferencesRepository {
  Future<UserPreferences> loadPreferences();
  Future<void> savePreferences(UserPreferences preferences);
}