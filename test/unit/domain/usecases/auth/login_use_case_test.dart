import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/data/models/account/account_model.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/usecases/auth/login_use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  final tAccount = AccountModel(
    taxIdOrIds: ['123'],
    username: 'user',
    passwordHash: 'hash',
    salt: 'salt',
    fullName: 'Full Name',
    enabled: true,
    updatedAt: DateTime.now(),
  );

  test('should login and return account from the repository', () async {
    // arrange
    when(() => mockRepository.login(
          taxIdOrId: any(named: 'taxIdOrId'),
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => Either.right(tAccount));

    // act
    final result = await useCase(LoginParams(
      taxIdOrId: '123',
      username: 'user',
      password: 'password',
    ));

    // assert
    expect(result, Either.right(tAccount));
    verify(() => mockRepository.login(
          taxIdOrId: '123',
          username: 'user',
          password: 'password',
        )).called(1);
  });

  test('should return AppException when login fails', () async {
    // arrange
    final tException = UnauthenticatedException(message: 'Invalid credentials');
    when(() => mockRepository.login(
          taxIdOrId: any(named: 'taxIdOrId'),
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => Either.left(tException));

    // act
    final result = await useCase(LoginParams(
      taxIdOrId: '123',
      username: 'user',
      password: 'password',
    ));

    // assert
    expect(result, Either.left(tException));
    verify(() => mockRepository.login(
          taxIdOrId: '123',
          username: 'user',
          password: 'password',
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
