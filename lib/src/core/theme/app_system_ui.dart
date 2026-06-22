import 'package:crud_app/src/core/dimensions/app_color.dart';
import 'package:flutter/services.dart';

class AppSystemUi {
  const AppSystemUi._();

  static SystemUiOverlayStyle get light => SystemUiOverlayStyle(
    statusBarColor: AppColor.surfaceLight,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColor.surfaceLight,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static SystemUiOverlayStyle get dark => const SystemUiOverlayStyle(
    statusBarColor: AppColor.surfaceDark,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColor.surfaceDark,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}
