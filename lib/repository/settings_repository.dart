import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  String defaultLanguage;

  SettingsRepository(this.defaultLanguage);

  void setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("language", language);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final storedLanguage = prefs.getString("language");
    final language = storedLanguage ?? defaultLanguage;
    if (language != "en" && language != "ru") {
      return "en";
    }
    return language;
  }
}
