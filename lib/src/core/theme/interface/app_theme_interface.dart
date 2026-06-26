part of '../app_theme.dart';

abstract class AppThemeData {
  AppColorScheme get appColorScheme;

  AppTextTheme get appTextTheme;

  ThemeData get themeData;

  SystemUiOverlayStyle get systemOverlayStyle;

  void setAppColorScheme(AppColorScheme appColorScheme);
}

abstract class AppColorScheme {
  // Primary
  Color get primary;

  Color get onPrimary;

  Color get primaryContainer;

  Color get onPrimaryContainer;

  // Secondary
  Color get secondary;

  Color get onSecondary;

  Color get secondaryContainer;

  Color get onSecondaryContainer;

  // Surface
  Color get surface;

  Color get surfaceContainer;

  Color get surfaceContainerHigh;

  Color get surfaceContainerHighest;

  // On Surface
  Color get onSurface;

  Color get onSurfaceContainer;

  Color get onSurfaceContainerHigh;

  Color get onSurfaceContainerHighest;

  Color get onSurfaceLight;

  // Outline
  Color get outline;

  Color get outlineLightest;

  Color get outlineMedium;

  Color get outlineStrong;

  // Status
  Color get errorText;

  Color get errorContainer;

  Color get warningText;

  Color get warningContainer;

  Color get successText;

  Color get successContainer;

  Color get indicatorSelect;

  Color get filterBar;

  //Text
  Color get textField;

  Color get primaryLight;

  Color get black0;

  Color get grayLight1;

  Color get grayLight2;

  Color get grayLight3;

  Color get grayLight6;

  Color get grayLight7;

  Color get btnShadow;
}

abstract class AppTextTheme {
  TextStyle get bodyTiny;

  TextStyle get bodySmall;

  TextStyle get bodyMedium;

  TextStyle get bodyLarge;

  TextStyle get titleSmall;

  TextStyle get titleMedium;

  TextStyle get titleLarge;

  TextStyle get headlineSmall;

  TextStyle get headlineMedium;

  TextStyle get headlineLarge;

  TextStyle get body16Bo;

  TextStyle get body16Semi;

  TextStyle get des12Re;

  TextStyle get des12Semi;
}
