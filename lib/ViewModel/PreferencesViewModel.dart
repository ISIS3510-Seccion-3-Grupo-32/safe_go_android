import 'package:flutter/cupertino.dart';
import '../Service Providers/FirebaseServiceProvider.dart';
import '../Model/UpdatePreferences.dart';

class PreferencesViewModel extends ChangeNotifier {
  Future<Object?> sendNewPreferences(
      String userId, bool isDark, bool isNotif, String lang, double volume) {
    return sendPreferencesToDatabase(
        userId, isDark, isNotif, lang, volume, 'usersPreferences');
  }

  Future<Object?> updatePreferences(String userId, bool isDarkMode,
      bool isNotificationsOn, double volume, String language) {
    return updatePreferenceValue(userId, 'usersPreferences', isDarkMode,
        isNotificationsOn, volume, language);
  }
}
