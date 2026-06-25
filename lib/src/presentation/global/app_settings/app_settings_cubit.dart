import 'dart:developer';

import 'package:dart_either/dart_either.dart';
import 'package:equatable/equatable.dart';
import 'package:crud_app/configs/app_config.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/src/domain/models/enum/language.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  final SettingRepository _settingRepository;

  AppSettingsCubit({required SettingRepository settingRepository})
    : _settingRepository = settingRepository,
      super(const AppSettingsState());

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
          emit(
            state.copyWith(
              language: language,
              useBiometrics: useBiometricsResult,
            ),
          );
        }
        return null;
      },
      onError: (failure) {
        log("Error language: $failure");
      },
    );

    await themeModeResult.foldResult(
      onSuccess: (themeMode) {
        emit(state.copyWith(themeMode: themeMode));
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
        emit(state.copyWith(language: language));
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
        emit(state.copyWith(themeMode: themeMode));
      },
      onError: (failure) {
        log("Error: $failure");
      },
    );
  }

  void changeUseBiometrics({required bool useBiometrics}) async {
    await _settingRepository.setUseBiometrics(useBiometrics);
    emit(state.copyWith(useBiometrics: useBiometrics));
  }
}
