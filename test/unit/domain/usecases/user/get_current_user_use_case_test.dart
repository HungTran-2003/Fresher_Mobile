import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/domain/repositories/user_repository.dart';
import 'package:crud_app/src/domain/usecases/user/get_current_user_use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late GetCurrentUserUseCase useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetCurrentUserUseCase(mockRepository);
  });

  const tUser = UserEntity(
    id: '1',
    userName: 'test_user',
    fullName: 'Test User',
    email: 'test@example.com',
  );

  test('should get current user from the repository', () async {
    // arrange
    when(() => mockRepository.getCurrentUser(any(), any()))
        .thenAnswer((_) async => Either.right(tUser));

    // act
    final result = await useCase(GetCurrentUserParams(
      taxIdOrId: '12345',
      username: 'test_user',
    ));

    // assert
    expect(result, Either.right(tUser));
    verify(() => mockRepository.getCurrentUser('12345', 'test_user')).called(1);
  });

  test('should return AppException when repository fails', () async {
    // arrange
    final tException = ServerException(message: 'User not found');
    when(() => mockRepository.getCurrentUser(any(), any()))
        .thenAnswer((_) async => Either.left(tException));

    // act
    final result = await useCase(GetCurrentUserParams(
      taxIdOrId: '12345',
      username: 'test_user',
    ));

    // assert
    expect(result, Either.left(tException));
    verify(() => mockRepository.getCurrentUser('12345', 'test_user')).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
