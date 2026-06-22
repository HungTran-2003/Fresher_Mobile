import 'package:crud_app/configs/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingsState {
  final language = AppConfigs.defaultLanguage.obs;
  final themeMode = ThemeMode.system.obs;
  final useBiometrics = false.obs;
}
