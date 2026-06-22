import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_navigator.dart';
import 'package:crud_app/src/presentation/screens/home/product_detail/product_detail_controller.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockAddProductNavigator extends Mock implements AddProductNavigator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProductDetailController productDetailController;
  late MockProductRepository productRepository;
  late MockAddProductNavigator addProductNavigator;

  const tProduct = ProductEntity(
    id: 1,
    status: 1,
    createdAt: '2025-12-08T07:00:00+07:00',
    updatedAt: '2025-12-08T07:00:00+07:00',
    name: 'Old Name',
    code: 'P1',
    price: 100,
    stock: 10,
  );

  setUp(() async {
    productRepository = MockProductRepository();
    addProductNavigator = MockAddProductNavigator();
    
    await S.load(const Locale('en'));

    when(() => productRepository.getCategories())
        .thenAnswer((_) async => const Right([]));

    productDetailController = ProductDetailController(
      productRepository: productRepository,
      navigator: addProductNavigator,
      initialProduct: tProduct,
    );
    
    productDetailController.onInit();

    when(() => addProductNavigator.showSuccessSnackBar(message: any(named: 'message')))
        .thenAnswer((_) async {});
    when(() => addProductNavigator.pop(any())).thenAnswer((_) async {});
  });

  group('ProductDetailController', () {
    test('initializes state from product argument', () {
      expect(productDetailController.state.name.value, 'Old Name');
      expect(productDetailController.product, tProduct);
    });

    test('updateProduct updates status to success when successful', () async {
      productDetailController.state.name.value = 'Updated Name';
      
      when(() => productRepository.updateProduct(
            id: any(named: 'id'),
            name: any(named: 'name'),
            code: any(named: 'code'),
            price: any(named: 'price'),
            stock: any(named: 'stock'),
            categoryId: any(named: 'categoryId'),
            status: any(named: 'status'),
            tags: any(named: 'tags'),
            description: any(named: 'description'),
            image: any(named: 'image'),
          )).thenAnswer((_) async => const Right(null));

      await productDetailController.updateProduct();

      expect(productDetailController.state.status.value, LoadStatus.success);
      verify(() => productRepository.updateProduct(
            id: 1,
            name: 'Updated Name',
            code: 'P1',
            price: 100.0,
            stock: 10,
            categoryId: any(named: 'categoryId'),
            status: any(named: 'status'),
            tags: any(named: 'tags'),
            description: any(named: 'description'),
            image: any(named: 'image'),
          )).called(1);
    });
  });
}
