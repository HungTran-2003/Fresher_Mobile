import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/product/delete_product_use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late DeleteProductUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = DeleteProductUseCase(mockRepository);
  });

  const tId = 1;

  test('should call deleteProduct on the repository', () async {
    // arrange
    when(() => mockRepository.deleteProduct(any()))
        .thenAnswer((_) async => const Either.right(null));

    // act
    final result = await useCase(tId);

    // assert
    expect(result, const Either.right(null));
    verify(() => mockRepository.deleteProduct(tId)).called(1);
  });

  test('should return AppException when repository fails', () async {
    // arrange
    final tException = ServerException(message: 'Failed to delete product');
    when(() => mockRepository.deleteProduct(any()))
        .thenAnswer((_) async => Either.left(tException));

    // act
    final result = await useCase(tId);

    // assert
    expect(result, Either.left(tException));
    verify(() => mockRepository.deleteProduct(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
