import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/enum/language.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';

class GetLanguageUseCase extends UseCase<Language?, NoParams> {
  final SettingRepository _repository;
  GetLanguageUseCase(this._repository);
  @override
  Future<Either<AppException, Language?>> call(NoParams params) => _repository.getCurrentLanguage();
}

class SetLanguageUseCase extends UseCase<void, Language> {
  final SettingRepository _repository;
  SetLanguageUseCase(this._repository);
  @override
  Future<Either<AppException, void>> call(Language language) => _repository.setCurrentLanguage(language);
}

class GetThemeModeUseCase extends UseCase<ThemeMode, NoParams> {
  final SettingRepository _repository;
  GetThemeModeUseCase(this._repository);
  @override
  Future<Either<AppException, ThemeMode>> call(NoParams params) => _repository.getThemeMode();
}

class SetThemeModeUseCase extends UseCase<void, ThemeMode> {
  final SettingRepository _repository;
  SetThemeModeUseCase(this._repository);
  @override
  Future<Either<AppException, void>> call(ThemeMode themeMode) => _repository.setThemeMode(themeMode);
}

class GetBiometricsUseCase {
  final SettingRepository _repository;
  GetBiometricsUseCase(this._repository);
  Future<bool> call() => _repository.getUseBiometrics();
}

class SetBiometricsUseCase extends UseCase<void, bool> {
  final SettingRepository _repository;
  SetBiometricsUseCase(this._repository);
  @override
  Future<Either<AppException, void>> call(bool useBiometrics) => _repository.setUseBiometrics(useBiometrics);
}

class CheckFirstRunUseCase extends UseCase<bool, NoParams> {
  final SettingRepository _repository;
  CheckFirstRunUseCase(this._repository);
  @override
  Future<Either<AppException, bool>> call(NoParams params) => _repository.isFirstRun();
}

class SetFirstRunUseCase extends UseCase<void, bool> {
  final SettingRepository _repository;
  SetFirstRunUseCase(this._repository);
  @override
  Future<Either<AppException, void>> call(bool isFirstRun) => _repository.setFirstRun(isFirstRun: isFirstRun);
}
