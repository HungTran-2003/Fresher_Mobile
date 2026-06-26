import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/enum/language.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/domain/usecases/setting/setting_use_cases.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingRepository extends Mock implements SettingRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(Language.english);
    registerFallbackValue(ThemeMode.light);
  });

  late MockSettingRepository mockRepository;

  setUp(() {
    mockRepository = MockSettingRepository();
  });

  group('GetLanguageUseCase', () {
    test('should call getCurrentLanguage on the repository', () async {
      final useCase = GetLanguageUseCase(mockRepository);
      when(() => mockRepository.getCurrentLanguage())
          .thenAnswer((_) async => const Either.right(Language.english));

      final result = await useCase(NoParams());

      expect(result, const Either.right(Language.english));
      verify(() => mockRepository.getCurrentLanguage()).called(1);
    });

    test('should return AppException when repository fails', () async {
      final useCase = GetLanguageUseCase(mockRepository);
      final tException = ServerException(message: 'Error');
      when(() => mockRepository.getCurrentLanguage())
          .thenAnswer((_) async => Either.left(tException));

      final result = await useCase(NoParams());

      expect(result, Either.left(tException));
    });
  });

  group('SetLanguageUseCase', () {
    test('should call setCurrentLanguage on the repository', () async {
      final useCase = SetLanguageUseCase(mockRepository);
      when(() => mockRepository.setCurrentLanguage(any()))
          .thenAnswer((_) async => const Either.right(null));

      final result = await useCase(Language.english);

      expect(result, const Either.right(null));
      verify(() => mockRepository.setCurrentLanguage(Language.english)).called(1);
    });

    test('should return AppException when repository fails', () async {
      final useCase = SetLanguageUseCase(mockRepository);
      final tException = ServerException(message: 'Error');
      when(() => mockRepository.setCurrentLanguage(any()))
          .thenAnswer((_) async => Either.left(tException));

      final result = await useCase(Language.english);

      expect(result, Either.left(tException));
    });
  });

  group('GetThemeModeUseCase', () {
    test('should call getThemeMode on the repository', () async {
      final useCase = GetThemeModeUseCase(mockRepository);
      when(() => mockRepository.getThemeMode())
          .thenAnswer((_) async => const Either.right(ThemeMode.dark));

      final result = await useCase(NoParams());

      expect(result, const Either.right(ThemeMode.dark));
      verify(() => mockRepository.getThemeMode()).called(1);
    });
  });

  group('SetThemeModeUseCase', () {
    test('should call setThemeMode on the repository', () async {
      final useCase = SetThemeModeUseCase(mockRepository);
      when(() => mockRepository.setThemeMode(any()))
          .thenAnswer((_) async => const Either.right(null));

      final result = await useCase(ThemeMode.dark);

      expect(result, const Either.right(null));
      verify(() => mockRepository.setThemeMode(ThemeMode.dark)).called(1);
    });
  });

  group('GetBiometricsUseCase', () {
    test('should call getUseBiometrics on the repository', () async {
      final useCase = GetBiometricsUseCase(mockRepository);
      when(() => mockRepository.getUseBiometrics()).thenAnswer((_) async => true);

      final result = await useCase();

      expect(result, true);
      verify(() => mockRepository.getUseBiometrics()).called(1);
    });
  });

  group('SetBiometricsUseCase', () {
    test('should call setUseBiometrics on the repository', () async {
      final useCase = SetBiometricsUseCase(mockRepository);
      when(() => mockRepository.setUseBiometrics(any()))
          .thenAnswer((_) async => const Either.right(null));

      final result = await useCase(true);

      expect(result, const Either.right(null));
      verify(() => mockRepository.setUseBiometrics(true)).called(1);
    });
  });

  group('CheckFirstRunUseCase', () {
    test('should call isFirstRun on the repository', () async {
      final useCase = CheckFirstRunUseCase(mockRepository);
      when(() => mockRepository.isFirstRun())
          .thenAnswer((_) async => const Either.right(true));

      final result = await useCase(NoParams());

      expect(result, const Either.right(true));
      verify(() => mockRepository.isFirstRun()).called(1);
    });
  });

  group('SetFirstRunUseCase', () {
    test('should call setFirstRun on the repository', () async {
      final useCase = SetFirstRunUseCase(mockRepository);
      when(() => mockRepository.setFirstRun(isFirstRun: any(named: 'isFirstRun')))
          .thenAnswer((_) async => const Either.right(null));

      final result = await useCase(false);

      expect(result, const Either.right(null));
      verify(() => mockRepository.setFirstRun(isFirstRun: false)).called(1);
    });
  });
}
