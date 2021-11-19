class SettingsRepository {

  // TODO: store in actual local storage
  String language;

  SettingsRepository(this.language);

  void setLanguage(String language) {
    this.language = language;
  }

  String getLanguage() {
    if (language != "en" && language != "ru") {
      return "en";
    }
    return language;
  }
}