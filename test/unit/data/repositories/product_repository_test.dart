import 'package:crud_app/src/data/models/base_response.dart';
import 'package:crud_app/src/data/models/product/category_model.dart';
import 'package:crud_app/src/data/models/product/product_model.dart';
import 'package:crud_app/src/data/repositories/product_repository_impl.dart';
import 'package:crud_app/src/data/services/network/dio_client.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  late ProductRepositoryImpl repository;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    repository = ProductRepositoryImpl(dioClient: mockDioClient);
  });

  group('ProductRepositoryImpl', () {
    test('getCategories should return list of CategoryEntity on success', () async {
      // Arrange
      final mockResponse = BaseListResponse<CategoryModel>(
        data: [
          CategoryModel(
            id: 1,
            status: 1,
            createdAt: '2023-01-01',
            updatedAt: '2023-01-01',
            name: 'Category 1',
          ),
        ],
      );
      when(() => mockDioClient.getCategories()).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getCategories();

      // Assert
      expect(result.isRight, true);
      result.foldResult(
        onError: (l) => fail('Should be right'),
        onSuccess: (r) {
          expect(r.length, 1);
          expect(r[0].name, 'Category 1');
        },
      );
    });

    test('getProducts should return list of ProductEntity on success', () async {
      // Arrange
      final mockResponse = BaseListResponse<ProductModel>(
        data: [
          ProductModel(
            id: 1,
            status: 1,
            createdAt: '2023-01-01',
            updatedAt: '2023-01-01',
            name: 'Product 1',
            code: 'P1',
            price: 100.0,
            stock: 10,
          ),
        ],
      );
      when(() => mockDioClient.getProducts(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
            categoryId: any(named: 'categoryId'),
          )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getProducts(page: 1, limit: 10);

      // Assert
      expect(result.isRight, true);
      result.foldResult(
        onError: (l) => fail('Should be right'),
        onSuccess: (r) {
          expect(r.length, 1);
          expect(r[0].name, 'Product 1');
        },
      );
    });
  });
}
