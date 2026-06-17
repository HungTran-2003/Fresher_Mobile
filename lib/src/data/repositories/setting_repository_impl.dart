import 'dart:developer';

import 'package:dart_either/dart_either.dart';
import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/services/database/share_preferrences_data_source.dart';
import 'package:crud_app/src/domain/models/enum/language.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:flutter/material.dart';

class SettingRepositoryImpl extends SettingRepository {

  SettingRepositoryImpl();

  @override
  Future<Either<AppException, Language?>> getCurrentLanguage() async {
    try {
      final language = SharedPreferencesDataSource.instance.getCurrentLanguage();
      return Either.right(language);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, void>> setCurrentLanguage(
    Language language,
  ) async {
    try {
      await SharedPreferencesDataSource.instance.setCurrentLanguage(language);
      return const Either.right(null);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, void>> setFirstRun({
    required bool isFirstRun,
  }) async {
    try {
      await SharedPreferencesDataSource.instance.setFirstRun(isFirstRun: isFirstRun);
      return const Either.right(null);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, bool>> isFirstRun() async {
    try {
      final isFirstRun = SharedPreferencesDataSource.instance.isFirstRun();
      return Either.right(isFirstRun);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, ThemeMode>> getThemeMode() async {
    try {
      final themeModeStr = SharedPreferencesDataSource.instance.getThemeMode();
      final themeMode = ThemeMode.values.firstWhere(
        (e) => e.name == themeModeStr,
        orElse: () => ThemeMode.system,
      );
      return Either.right(themeMode);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, void>> setThemeMode(ThemeMode themeMode) async {
    try {
      await SharedPreferencesDataSource.instance.setThemeMode(themeMode.name);
      return const Either.right(null);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<Either<AppException, void>> setUseBiometrics(bool useBiometrics) async {
    try {
      await SharedPreferencesDataSource.instance.setUseBiometrics(useBiometrics);
      return const Either.right(null);
    } catch (e) {
      return Either.left(ExceptionMapper.map(e));
    }
  }

  @override
  Future<bool> getUseBiometrics() async {
    try {
      final useBio = SharedPreferencesDataSource.instance.getUseBiometrics();
      return useBio;

      } catch (e) {
      log("getUseBiometricsError: ${e.toString()}");
      return false;
    }
  }
}
