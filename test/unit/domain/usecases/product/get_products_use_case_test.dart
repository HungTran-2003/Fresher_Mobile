import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/product/get_products_use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductsUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProductsUseCase(mockRepository);
  });

  final tProducts = [
    ProductEntity(
      id: 1,
      name: 'Test Product',
      code: 'TP1',
      price: 100,
      stock: 10,
      status: 1,
      createdAt: '',
      updatedAt: '',
    ),
  ];

  test('should get products from the repository', () async {
    // arrange
    when(() => mockRepository.getProducts(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          search: any(named: 'search'),
          categoryId: any(named: 'categoryId'),
        )).thenAnswer((_) async => Either.right(tProducts));

    // act
    final result = await useCase(GetProductsParams(page: 1, limit: 10));

    // assert
    expect(result, Either.right(tProducts));
    verify(() => mockRepository.getProducts(page: 1, limit: 10)).called(1);
  });

  test('should return AppException when repository fails', () async {
    // arrange
    final tException = NetworkException(message: 'No internet');
    when(() => mockRepository.getProducts(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          search: any(named: 'search'),
          categoryId: any(named: 'categoryId'),
        )).thenAnswer((_) async => Either.left(tException));

    // act
    final result = await useCase(GetProductsParams(page: 1, limit: 10));

    // assert
    expect(result, Either.left(tException));
    verify(() => mockRepository.getProducts(page: 1, limit: 10)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
