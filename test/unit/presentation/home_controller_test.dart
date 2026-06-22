import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/screens/home/home_controller.dart';
import 'package:crud_app/src/presentation/screens/home/home_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockHomeNavigator extends Mock implements HomeNavigator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeController homeController;
  late MockProductRepository productRepository;
  late MockHomeNavigator homeNavigator;

  const tProducts = [
    ProductEntity(
      id: 1,
      status: 1,
      createdAt: '2025-12-08T07:00:00+07:00',
      updatedAt: '2025-12-08T07:00:00+07:00',
      name: 'Product 1',
      code: 'P1',
      price: 100,
      stock: 10,
    ),
  ];

  setUp(() async {
    productRepository = MockProductRepository();
    homeNavigator = MockHomeNavigator();
    
    await S.load(const Locale('en'));

    when(() => productRepository.getCategories())
        .thenAnswer((_) async => const Right([]));
    
    homeController = HomeController(
      productRepository: productRepository,
      navigator: homeNavigator,
    );

    when(() => homeNavigator.showSuccessSnackBar(message: any(named: 'message')))
        .thenAnswer((_) async {});

    registerFallbackValue(1);
  });

  group('HomeController', () {
    test('initial state is correct', () {
      expect(homeController.state.status.value, LoadStatus.initial);
      expect(homeController.state.products, isEmpty);
    });

    test('loadProducts updates products list when successful', () async {
      when(() => productRepository.getProducts(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
            categoryId: any(named: 'categoryId'),
          )).thenAnswer((_) async => const Right(tProducts));

      await homeController.loadProducts(isRefresh: true);

      expect(homeController.state.products, tProducts);
      expect(homeController.state.isProductsLoading.value, false);
      verify(() => productRepository.getProducts(page: 1, limit: 10)).called(1);
    });

    test('deleteProduct removes product from list', () async {
      homeController.state.products.assignAll(tProducts);
      
      when(() => productRepository.deleteProduct(any()))
          .thenAnswer((_) async => const Right(null));

      await homeController.deleteProduct(1);

      expect(homeController.state.products, isEmpty);
      expect(homeController.state.status.value, LoadStatus.success);
      verify(() => productRepository.deleteProduct(1)).called(1);
    });
  });
}
