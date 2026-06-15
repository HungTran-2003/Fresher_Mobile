import 'package:dart_either/dart_either.dart';
import 'package:finance/src/core/exceptions/app_exception.dart';
import 'package:finance/src/domain/models/enum/language.dart';
import 'package:flutter/material.dart';

abstract class SettingRepository {
  Future<Either<AppException, Language?>> getCurrentLanguage();
  Future<Either<AppException, void>> setCurrentLanguage(Language language);
  Future<Either<AppException, void>> setFirstRun({required bool isFirstRun});
  Future<Either<AppException, bool>> isFirstRun();
  Future<Either<AppException, ThemeMode>> getThemeMode();
  Future<Either<AppException, void>> setThemeMode(ThemeMode themeMode);
}
