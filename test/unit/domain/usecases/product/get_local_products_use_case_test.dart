import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/product/get_local_products_use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetLocalProductsUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetLocalProductsUseCase(mockRepository);
  });

  final tProducts = [
    const ProductEntity(
      id: 1,
      name: 'Local Product',
      code: 'LP1',
      price: 100,
      stock: 10,
      status: 1,
      createdAt: '',
      updatedAt: '',
    ),
  ];

  test('should get products from the local repository', () async {
    // arrange
    when(() => mockRepository.getLocalProducts(
          search: any(named: 'search'),
          categoryId: any(named: 'categoryId'),
        )).thenAnswer((_) async => Either.right(tProducts));

    // act
    final result = await useCase(GetLocalProductsParams());

    // assert
    expect(result, Either.right(tProducts));
    verify(() => mockRepository.getLocalProducts()).called(1);
  });

  test('should return AppException when local repository fails', () async {
    // arrange
    final tException = UnknownException(message: 'Hive error');
    when(() => mockRepository.getLocalProducts(
          search: any(named: 'search'),
          categoryId: any(named: 'categoryId'),
        )).thenAnswer((_) async => Either.left(tException));

    // act
    final result = await useCase(GetLocalProductsParams());

    // assert
    expect(result, Either.left(tException));
    verify(() => mockRepository.getLocalProducts()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
