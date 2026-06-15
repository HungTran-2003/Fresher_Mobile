part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  final LoadStatus loadStatus;
  final Language language;
  final ThemeMode themeMode;

  const AppSettingsState({
    this.loadStatus = LoadStatus.initial,
    this.language = AppConfigs.defaultLanguage,
    this.themeMode = ThemeMode.dark,
  });

  @override
  List<Object?> get props => [loadStatus, language, themeMode];

  AppSettingsState copyWith({
    LoadStatus? loadStatus,
    Language? language,
    ThemeMode? themeMode,
  }) {
    return AppSettingsState(
      loadStatus: loadStatus ?? this.loadStatus,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
