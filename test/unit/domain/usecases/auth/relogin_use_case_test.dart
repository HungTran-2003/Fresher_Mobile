import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/usecases/auth/relogin_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late ReloginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = ReloginUseCase(mockRepository);
  });

  test('should call relogin on the repository and return a token', () async {
    // arrange
    const tToken = 'new_token';
    when(() => mockRepository.relogin()).thenAnswer((_) async => tToken);

    // act
    final result = await useCase();

    // assert
    expect(result, tToken);
    verify(() => mockRepository.relogin()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
