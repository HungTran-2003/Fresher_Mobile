import 'package:crud_app/src/data/models/base_response.dart';
import 'package:crud_app/src/data/models/product/category_model.dart';
import 'package:crud_app/src/data/models/product/product_model.dart';
import 'package:crud_app/src/data/repositories/product_repository_impl.dart';
import 'package:crud_app/src/data/services/hive/product/hive_product_service.dart';
import 'package:crud_app/src/data/services/network/dio_client.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements DioClient {}
class MockHiveProductService extends Mock implements HiveProductService {}

void main() {
  late ProductRepositoryImpl repository;
  late MockDioClient mockDioClient;
  late MockHiveProductService mockHiveService;

  setUp(() {
    mockDioClient = MockDioClient();
    mockHiveService = MockHiveProductService();
    repository = ProductRepositoryImpl(
      dioClient: mockDioClient,
      hiveService: mockHiveService,
    );
  });

  group('ProductRepositoryImpl', () {
    group('getRemoteProducts', () {
      test('should return remote products and sync to Hive on success', () async {
        // Arrange
        final remoteProduct = ProductModel(
          id: 1,
          status: 1,
          createdAt: '2023-01-01',
          updatedAt: '2023-01-02',
          name: 'Product 1',
          code: 'P1',
          price: 100.0,
          stock: 10,
        );
        final mockResponse = BaseListResponse<ProductModel>(
          data: [remoteProduct],
        );
        
        when(() => mockDioClient.getProducts(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          search: any(named: 'search'),
          categoryId: any(named: 'categoryId'),
        )).thenAnswer((_) async => mockResponse);
        
        when(() => mockHiveService.getProducts()).thenAnswer((_) async => []);
        when(() => mockHiveService.saveProducts(any())).thenAnswer((_) async => {});

        // Act
        final result = await repository.getRemoteProducts(page: 1, limit: 10);

        // Assert
        expect(result.isRight, true);
        verify(() => mockHiveService.saveProducts(any(that: isA<List<ProductModel>>()))).called(1);
      });

      test('should return error when backend request fails', () async {
        // Arrange
        when(() => mockDioClient.getProducts(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          search: any(named: 'search'),
          categoryId: any(named: 'categoryId'),
        )).thenThrow(Exception('Backend Error'));

        // Act
        final result = await repository.getRemoteProducts(page: 1, limit: 10);

        // Assert
        expect(result.isLeft, true);
        verifyNever(() => mockHiveService.getProducts());
      });
    });

    group('getLocalProducts', () {
      test('should return local products from Hive', () async {
        // Arrange
        final localProduct = ProductModel(
          id: 1,
          status: 1,
          createdAt: '2023-01-01',
          updatedAt: '2023-01-01',
          name: 'Local Product',
          code: 'P1',
          price: 100.0,
          stock: 10,
        );

        when(() => mockHiveService.getProducts()).thenAnswer((_) async => [localProduct]);

        // Act
        final result = await repository.getLocalProducts();

        // Assert
        expect(result.isRight, true);
        result.foldResult(
          onError: (l) => fail('Should be right'),
          onSuccess: (r) {
            expect(r.length, 1);
            expect(r[0].name, 'Local Product');
          },
        );
      });
    });

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
  });
}
