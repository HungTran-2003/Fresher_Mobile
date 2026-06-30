import 'dart:developer';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/src/domain/models/enum/language.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_settings_state.dart';

class AppSettingsController extends GetxController {
  final SettingRepository _settingRepository;
  final state = AppSettingsState();

  AppSettingsController({required SettingRepository settingRepository})
    : _settingRepository = settingRepository;

  @override
  void onInit() {
    super.onInit();
    getInitialSetting();
  }

  Future<void> getInitialSetting() async {
    final results = await Future.wait([
      _settingRepository.getCurrentLanguage(),
      _settingRepository.getThemeMode(),
      _settingRepository.getUseBiometrics(),
    ]);

    final languageResult = results[0] as Either<dynamic, Language?>;
    final themeModeResult = results[1] as Either<dynamic, ThemeMode>;
    final useBiometricsResult = results[2] as bool;

    await languageResult.foldResult(
      onSuccess: (language) {
        if (language != null) {
          state.language.value = language;
          state.useBiometrics.value = useBiometricsResult;
          Get.updateLocale(language.local);
        }
        return null;
      },
      onError: (failure) {
        log("Error language: $failure");
      },
    );

    await themeModeResult.foldResult(
      onSuccess: (themeMode) {
        state.themeMode.value = themeMode;
        Get.changeThemeMode(themeMode);
      },
      onError: (failure) {
        log("Error theme: $failure");
      },
    );
  }

  void changeLanguage({required Language language}) async {
    final result = await _settingRepository.setCurrentLanguage(language);
    result.foldResult(
      onSuccess: (_) {
        state.language.value = language;
        Get.updateLocale(language.local);
      },
      onError: (failure) {
        log("Error: $failure");
      },
    );
  }

  void changeThemeMode({required ThemeMode themeMode}) async {
    final result = await _settingRepository.setThemeMode(themeMode);
    result.foldResult(
      onSuccess: (_) {
        state.themeMode.value = themeMode;
        Get.changeThemeMode(themeMode);
      },
      onError: (failure) {
        log("Error: $failure");
      },
    );
  }

  void changeUseBiometrics({required bool useBiometrics}) async {
    await _settingRepository.setUseBiometrics(useBiometrics);
    state.useBiometrics.value = useBiometrics;
  }
}
