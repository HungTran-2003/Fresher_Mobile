import 'package:crud_app/src/domain/models/enum/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataSource {
  static const _firstRunKey = 'first_run';
  static const _isOnboardedKey = 'is_onboarded';
  static const _currentLanguageKey = 'current_language';
  static const _themeModeKey = 'theme_mode';
  static const _lastTaxIdOrIdKey = 'last_tax_id_or_id';
  static const _lastUsernameKey = 'last_username';
  static const _useBiometricsKey = 'use_biometrics';

  final SharedPreferences _prefs;

  SharedPreferencesDataSource._(this._prefs);

  static SharedPreferencesDataSource? _instance;

  static SharedPreferencesDataSource get instance {
    if (_instance == null) {
      throw StateError(
        'SharedPreferencesDataSource has not been initialized. Call init() first.',
      );
    }
    return _instance!;
  }

  static void init(SharedPreferences prefs) {
    _instance = SharedPreferencesDataSource._(prefs);
  }

  bool isFirstRun() {
    return _prefs.getBool(_firstRunKey) ?? true;
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

  String getLastTaxIdOrId() {
    return _prefs.getString(_lastTaxIdOrIdKey) ?? '';
  }

  Future<void> setLastTaxIdOrId(String value) async {
    await _prefs.setString(_lastTaxIdOrIdKey, value);
  }

  String getLastUsername() {
    return _prefs.getString(_lastUsernameKey) ?? '';
  }

  Future<void> setLastUsername(String value) async {
    await _prefs.setString(_lastUsernameKey, value);
  }

  Future<void> setUseBiometrics(bool useBiometrics) async {
    await _prefs.setBool(_useBiometricsKey, useBiometrics);
  }

  bool getUseBiometrics() {
    return _prefs.getBool(_useBiometricsKey) ?? false;
  }

  Future<void> clearLastLogin() async {
    await _prefs.remove(_lastTaxIdOrIdKey);
    await _prefs.remove(_lastUsernameKey);
    await _prefs.remove(_useBiometricsKey);
    await _prefs.remove(_accessTokenKey);
  }

  static const _accessTokenKey = 'access_token';

  Future<void> setAccessToken(String token) async {
    await _prefs.setString(_accessTokenKey, token);
  }

  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }
}
