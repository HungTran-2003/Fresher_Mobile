import 'package:crud_app/src/core/dimensions/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSystemUi {
  const AppSystemUi._();

  static SystemUiOverlayStyle get light => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColor.surfaceLight,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  static SystemUiOverlayStyle get dark => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColor.surfaceDark,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}
