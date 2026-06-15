import 'package:crud_app/src/domain/models/enum/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataSource {
  static const _firstRunKey = 'first_run';
  static const _isOnboardedKey = 'is_onboarded';
  static const _currentLanguageKey = 'current_language';
  static const _themeModeKey = 'theme_mode';

  final SharedPreferences _prefs;

  SharedPreferencesDataSource(this._prefs);

  bool isFirstRun() {
    return _prefs.getBool(_firstRunKey) ?? false;
  }

  Future<void> setFirstRun({bool isFirstRun = true}) async {
    await _prefs.setBool(_firstRunKey, isFirstRun);
  }

  bool isOnboarded() {
    return _prefs.getBool(_isOnboardedKey) ?? false;
  }

  Future<void> setOnboarded({bool isOnboarded = true}) async {
    await _prefs.setBool(_isOnboardedKey, isOnboarded);
  }

  Language? getCurrentLanguage() {
    final languageCode = _prefs.getString(_currentLanguageKey) ?? '';
    return LanguageExt.languageFromCode(languageCode);
  }

  Future<void> setCurrentLanguage(Language language) async {
    await _prefs.setString(_currentLanguageKey, language.code);
  }

  String? getThemeMode() {
    return _prefs.getString(_themeModeKey);
  }

  Future<void> setThemeMode(String themeMode) async {
    await _prefs.setString(_themeModeKey, themeMode);
  }
}
