import 'package:crud_app/src/core/exceptions/app_exception.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/product/add_product_use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late AddProductUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = AddProductUseCase(mockRepository);
  });

  final tParams = AddProductParams(
    name: 'Test',
    code: 'T1',
    price: 10,
    stock: 5,
  );

  test('should call addProduct on the repository', () async {
    // arrange
    when(() => mockRepository.addProduct(
          name: any(named: 'name'),
          code: any(named: 'code'),
          price: any(named: 'price'),
          stock: any(named: 'stock'),
          categoryId: any(named: 'categoryId'),
          tags: any(named: 'tags'),
          status: any(named: 'status'),
          description: any(named: 'description'),
          image: any(named: 'image'),
        )).thenAnswer((_) async => const Either.right(null));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, const Either.right(null));
    verify(() => mockRepository.addProduct(
          name: tParams.name,
          code: tParams.code,
          price: tParams.price,
          stock: tParams.stock,
        )).called(1);
  });

  test('should return AppException when repository fails', () async {
    // arrange
    final tException = ServerException(message: 'Failed to add product');
    when(() => mockRepository.addProduct(
          name: any(named: 'name'),
          code: any(named: 'code'),
          price: any(named: 'price'),
          stock: any(named: 'stock'),
          categoryId: any(named: 'categoryId'),
          tags: any(named: 'tags'),
          status: any(named: 'status'),
          description: any(named: 'description'),
          image: any(named: 'image'),
        )).thenAnswer((_) async => Either.left(tException));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, Either.left(tException));
    verify(() => mockRepository.addProduct(
          name: tParams.name,
          code: tParams.code,
          price: tParams.price,
          stock: tParams.stock,
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
