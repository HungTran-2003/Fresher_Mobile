part of 'app_theme.dart';

// LIGHT THEME
class LightThemeData extends AppThemeData {
  AppColorScheme _colorScheme = LightColorScheme();

  @override
  AppColorScheme get appColorScheme => _colorScheme;

  @override
  AppTextTheme get appTextTheme => BaseAppTextTheme(_colorScheme);

  @override
  SystemUiOverlayStyle get systemOverlayStyle => AppSystemUi.light;

  @override
  void setAppColorScheme(AppColorScheme appColorScheme) {
    _colorScheme = appColorScheme;
  }

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.light,
    primaryColor: appColorScheme.primary,
    scaffoldBackgroundColor: appColorScheme.surface,
  );
}

class LightColorScheme extends AppColorScheme {
  @override
  Color get primary => AppColor.primary;

  @override
  Color get onPrimary => AppColor.onPrimary;

  @override
  Color get primaryContainer => AppColor.primaryContainerLight;

  @override
  Color get onPrimaryContainer => AppColor.onPrimaryContainerLight;

  @override
  Color get secondary => AppColor.secondary;

  @override
  Color get onSecondary => AppColor.onSecondary;

  @override
  Color get secondaryContainer => AppColor.secondaryContainerLight;

  @override
  Color get onSecondaryContainer => AppColor.onSecondaryContainerLight;

  @override
  Color get surface => AppColor.surfaceLight;

  @override
  Color get surfaceContainer => AppColor.surfaceContainerLight;

  @override
  Color get surfaceContainerHigh => AppColor.surfaceContainerHighLight;

  @override
  Color get surfaceContainerHighest => AppColor.surfaceContainerHighestLight;

  @override
  Color get onSurface => AppColor.onSurfaceLight;

  @override
  Color get onSurfaceContainer => AppColor.onSurfaceLight;

  @override
  Color get onSurfaceContainerHigh => AppColor.onSurfaceLight;

  @override
  Color get onSurfaceContainerHighest => AppColor.onSurfaceLight;

  @override
  Color get onSurfaceLight => AppColor.onSurfaceLight;

  @override
  Color get outline => AppColor.outlineLight;

  @override
  Color get outlineLightest => AppColor.outlineLightestLight;

  @override
  Color get outlineMedium => AppColor.outlineMediumLight;

  @override
  Color get outlineStrong => AppColor.outlineStrongLight;

  @override
  Color get errorText => AppColor.error;

  @override
  Color get errorContainer => AppColor.errorContainerLight;

  @override
  Color get successText => AppColor.success;

  @override
  Color get successContainer => AppColor.successContainerLight;

  @override
  Color get warningText => AppColor.warning;

  @override
  Color get warningContainer => AppColor.warningContainerLight;

  @override
  Color get indicatorSelect => AppColor.indicatorSelectLight;

  @override
  Color get textField => AppColor.textFieldLight;

  @override
  Color get filterBar => AppColor.filterBarLight;

  @override
  Color get primaryLight => AppColor.primaryLight2;

  @override
  Color get black0 => AppColor.black0;

  @override
  Color get grayLight3 => AppColor.grayLight3;

  @override
  Color get grayLight1 => AppColor.grayLight1;

  @override
  Color get grayLight2 => AppColor.grayLight2;

  @override
  Color get grayLight6 => AppColor.grayLight6;

  @override
  Color get grayLight7 => AppColor.grayLight7;

  @override
  Color get btnShadow => AppColor.btnShadow;

}

// DARK THEME
class DarkThemeData extends AppThemeData {
  AppColorScheme _colorScheme = DarkColorScheme();

  @override
  AppColorScheme get appColorScheme => _colorScheme;

  @override
  AppTextTheme get appTextTheme => BaseAppTextTheme(_colorScheme);

  @override
  void setAppColorScheme(AppColorScheme appColorScheme) {
    _colorScheme = appColorScheme;
  }

  @override
  SystemUiOverlayStyle get systemOverlayStyle => AppSystemUi.dark;

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.dark,
    primaryColor: appColorScheme.primary,
    scaffoldBackgroundColor: appColorScheme.surface,
  );
}

class DarkColorScheme extends AppColorScheme {
  @override
  Color get primary => AppColor.primary;

  @override
  Color get onPrimary => AppColor.onPrimary;

  @override
  Color get primaryContainer => AppColor.primaryContainerDark;

  @override
  Color get onPrimaryContainer => AppColor.onPrimaryContainerDark;

  @override
  Color get secondary => AppColor.secondary;

  @override
  Color get onSecondary => AppColor.onSecondary;

  @override
  Color get secondaryContainer => AppColor.secondaryContainerDark;

  @override
  Color get onSecondaryContainer => AppColor.onSecondaryContainerDark;

  @override
  Color get surface => AppColor.surfaceDark;

  @override
  Color get surfaceContainer => AppColor.surfaceContainerDark;

  @override
  Color get surfaceContainerHigh => AppColor.surfaceContainerHighDark;

  @override
  Color get surfaceContainerHighest => AppColor.surfaceContainerHighestDark;

  @override
  Color get onSurface => AppColor.onSurfaceDark;

  @override
  Color get onSurfaceContainer => AppColor.onSurfaceDark;

  @override
  Color get onSurfaceContainerHigh => AppColor.onSurfaceDark;

  @override
  Color get onSurfaceContainerHighest => AppColor.onSurfaceDark;

  @override
  Color get onSurfaceLight => AppColor.onSurfaceLight;

  @override
  Color get outline => AppColor.outlineDark;

  @override
  Color get outlineLightest => AppColor.outlineLightestDark;

  @override
  Color get outlineMedium => AppColor.outlineMediumDark;

  @override
  Color get outlineStrong => AppColor.outlineStrongDark;

  @override
  Color get errorText => AppColor.error;

  @override
  Color get errorContainer => AppColor.errorContainerDark;

  @override
  Color get successText => AppColor.success;

  @override
  Color get successContainer => AppColor.successContainerDark;

  @override
  Color get warningText => AppColor.warning;

  @override
  Color get warningContainer => AppColor.warningContainerDark;

  @override
  Color get indicatorSelect => AppColor.indicatorSelectDark;

  @override
  Color get textField => AppColor.textFieldDark;

  @override
  Color get filterBar => AppColor.filterBarDark;

  @override
  Color get primaryLight => AppColor.primary;

  @override
  Color get black0 => Colors.white;

  @override
  Color get grayLight3 => AppColor.grayLight7;

  @override
  Color get grayLight1 => AppColor.grayLight1;

  @override
  Color get grayLight6 => AppColor.grayLight6;

  @override
  Color get grayLight2 => AppColor.grayLight2;

  @override
  Color get grayLight7 => AppColor.grayLight7;

  @override
  Color get btnShadow => AppColor.btnShadow;
}

// SHARED TEXT THEME IMPLEMENTATION
class BaseAppTextTheme extends AppTextTheme {
  final AppColorScheme colorScheme;

  BaseAppTextTheme(this.colorScheme);

  @override
  TextStyle get bodyLarge =>
      AppTypography.bodyLarge.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get bodyMedium =>
      AppTypography.bodyMedium.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get bodySmall =>
      AppTypography.bodySmall.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get bodyTiny =>
      AppTypography.bodyTiny.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get headlineLarge =>
      AppTypography.headlineLarge.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get headlineMedium =>
      AppTypography.headlineMedium.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get headlineSmall =>
      AppTypography.headlineSmall.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get titleLarge =>
      AppTypography.titleLarge.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get titleMedium =>
      AppTypography.titleMedium.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get titleSmall =>
      AppTypography.titleSmall.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get body16Bo =>
      AppTypography.body16Bo.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get body16Semi =>
      AppTypography.body16Semi.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get des12Re =>
      AppTypography.des12Re.copyWith(color: colorScheme.onSurface);

  @override
  TextStyle get des12Semi =>
      AppTypography.des12Semi.copyWith(color: colorScheme.onSurface);
}
