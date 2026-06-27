import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/usecases/product/delete_product_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_categories_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_local_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/process_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:crud_app/src/presentation/screens/home/home_controller.dart';
import 'package:crud_app/src/presentation/screens/home/home_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRemoteProductsUseCase extends Mock implements GetRemoteProductsUseCase {}
class MockGetLocalProductsUseCase extends Mock implements GetLocalProductsUseCase {}
class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}
class MockDeleteProductUseCase extends Mock implements DeleteProductUseCase {}
class MockProcessProductsUseCase extends Mock implements ProcessProductsUseCase {}
class MockHomeNavigator extends Mock implements HomeNavigator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HomeController controller;
  late MockGetRemoteProductsUseCase mockGetRemoteProductsUseCase;
  late MockGetLocalProductsUseCase mockGetLocalProductsUseCase;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockDeleteProductUseCase mockDeleteProductUseCase;
  late MockProcessProductsUseCase mockProcessProductsUseCase;
  late MockHomeNavigator mockHomeNavigator;

  setUpAll(() {
    registerFallbackValue(GetProductsParams(page: 1, limit: 10));
    registerFallbackValue(GetLocalProductsParams());
    registerFallbackValue(NoParams());
    registerFallbackValue(ProcessProductsParams(
      rawProducts: [],
      currentProducts: [],
      filterStatus: ProductStatusFilter.all,
      sortFilter: ProductSortFilter.defaultSort,
      isRefresh: true,
    ));
  });

  setUp(() {
    mockGetRemoteProductsUseCase = MockGetRemoteProductsUseCase();
    mockGetLocalProductsUseCase = MockGetLocalProductsUseCase();
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockDeleteProductUseCase = MockDeleteProductUseCase();
    mockProcessProductsUseCase = MockProcessProductsUseCase();
    mockHomeNavigator = MockHomeNavigator();

    controller = HomeController(
      getRemoteProductsUseCase: mockGetRemoteProductsUseCase,
      getLocalProductsUseCase: mockGetLocalProductsUseCase,
      getCategoriesUseCase: mockGetCategoriesUseCase,
      deleteProductUseCase: mockDeleteProductUseCase,
      processProductsUseCase: mockProcessProductsUseCase,
      navigator: mockHomeNavigator,
    );
  });

  group('HomeController', () {
    test('init should fetch categories and remote products when online', () async {
      // Arrange
      controller.state.isOffline.value = false;
      when(() => mockGetCategoriesUseCase.call(any())).thenAnswer(
        (_) async => const Either.right([]),
      );
      when(() => mockGetRemoteProductsUseCase.call(any())).thenAnswer(
        (_) async => const Either.right([]),
      );
      when(() => mockProcessProductsUseCase.call(any())).thenReturn([]);

      // Act
      await controller.init();

      // Assert
      expect(controller.state.productStatus.value, LoadStatus.success);
      verify(() => mockGetRemoteProductsUseCase.call(any())).called(1);
      verifyNever(() => mockGetLocalProductsUseCase.call(any()));
    });

    test('loadProducts should call getLocalProducts when offline', () async {
      // Arrange
      controller.state.isOffline.value = true;
      when(() => mockGetLocalProductsUseCase.call(any())).thenAnswer(
        (_) async => const Either.right([]),
      );
      when(() => mockProcessProductsUseCase.call(any())).thenReturn([]);

      // Act
      await controller.loadProducts(isRefresh: true);

      // Assert
      verify(() => mockGetLocalProductsUseCase.call(any())).called(1);
      verifyNever(() => mockGetRemoteProductsUseCase.call(any()));
    });

    test('deleteProduct should call showErrorSnackBar and not call usecase when offline', () async {
      // Arrange
      controller.state.isOffline.value = true;
      when(() => mockHomeNavigator.showErrorSnackBar(message: any(named: 'message')))
          .thenAnswer((_) async => {});

      // Act
      await controller.deleteProduct(1);

      // Assert
      verifyNever(() => mockDeleteProductUseCase.call(any()));
      verify(() => mockHomeNavigator.showErrorSnackBar(message: any(named: 'message'))).called(1);
    });

    test('deleteProduct should call usecase when online', () async {
      // Arrange
      controller.state.isOffline.value = false;
      final product = ProductEntity(
        id: 1,
        status: 1,
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        name: 'Test',
        code: 'P1',
        price: 10,
        stock: 5,
      );
      controller.state.products.add(product);
      when(() => mockDeleteProductUseCase.call(1)).thenAnswer(
        (_) async => const Either.right(null),
      );
      when(() => mockHomeNavigator.showSuccessSnackBar(message: any(named: 'message')))
          .thenAnswer((_) async => {});

      // Act
      await controller.deleteProduct(1);

      // Assert
      expect(controller.state.status.value, LoadStatus.success);
      verify(() => mockDeleteProductUseCase.call(1)).called(1);
    });
  });
}
