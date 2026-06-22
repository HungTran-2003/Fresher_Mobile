import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_controller.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockAddProductNavigator extends Mock implements AddProductNavigator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AddProductController addProductController;
  late MockProductRepository productRepository;
  late MockAddProductNavigator addProductNavigator;

  setUp(() async {
    productRepository = MockProductRepository();
    addProductNavigator = MockAddProductNavigator();
    
    await S.load(const Locale('en'));

    when(() => productRepository.getCategories())
        .thenAnswer((_) async => const Right([]));

    addProductController = AddProductController(
      productRepository: productRepository,
      navigator: addProductNavigator,
    );

    when(() => addProductNavigator.showSuccessSnackBar(message: any(named: 'message')))
        .thenAnswer((_) async {});
    when(() => addProductNavigator.pop(any())).thenAnswer((_) async {});
  });

  group('AddProductController', () {
    test('submit updates status to success when product added', () async {
      addProductController.state.name.value = 'New Product';
      addProductController.state.code.value = 'NP1';
      addProductController.state.price.value = '100';
      addProductController.state.stock.value = '10';

      when(() => productRepository.addProduct(
            name: any(named: 'name'),
            code: any(named: 'code'),
            price: any(named: 'price'),
            stock: any(named: 'stock'),
            categoryId: any(named: 'categoryId'),
            tags: any(named: 'tags'),
            status: any(named: 'status'),
            description: any(named: 'description'),
            image: any(named: 'image'),
          )).thenAnswer((_) async => const Right(null));

      await addProductController.submit();

      expect(addProductController.state.status.value, LoadStatus.success);
      verify(() => productRepository.addProduct(
            name: 'New Product',
            code: 'NP1',
            price: 100.0,
            stock: 10,
            categoryId: any(named: 'categoryId'),
            tags: any(named: 'tags'),
            status: any(named: 'status'),
            description: any(named: 'description'),
            image: any(named: 'image'),
          )).called(1);
    });
  });
}
