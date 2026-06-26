import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/usecases/auth/get_last_login_use_case.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GetLastLoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = GetLastLoginUseCase(mockRepository);
  });

  final tLastLogin = {'username': 'test_user', 'taxIdOrId': '12345'};

  test('should get last login from the repository', () async {
    // arrange
    when(() => mockRepository.getLastLogin())
        .thenAnswer((_) async => Either.right(tLastLogin));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Either.right(tLastLogin));
    verify(() => mockRepository.getLastLogin()).called(1);
  });

  test('should return AppException when repository fails', () async {
    // arrange
    final tException = ServerException(message: 'Failed to get last login');
    when(() => mockRepository.getLastLogin())
        .thenAnswer((_) async => Either.left(tException));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Either.left(tException));
    verify(() => mockRepository.getLastLogin()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
