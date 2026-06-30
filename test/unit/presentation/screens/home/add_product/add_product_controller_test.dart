import 'dart:io';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/repositories/upload_repository.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_controller.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockUploadRepository extends Mock implements UploadRepository {}
class MockAddProductNavigator extends Mock implements AddProductNavigator {}
class MockFile extends Mock implements File {}

void main() {
  late AddProductController controller;
  late MockProductRepository mockProductRepository;
  late MockUploadRepository mockUploadRepository;
  late MockAddProductNavigator mockAddProductNavigator;

  setUp(() {
    mockProductRepository = MockProductRepository();
    mockUploadRepository = MockUploadRepository();
    mockAddProductNavigator = MockAddProductNavigator();

    controller = AddProductController(
      productRepository: mockProductRepository,
      uploadRepository: mockUploadRepository,
      navigator: mockAddProductNavigator,
    );
  });

  group('AddProductController', () {
    test('onNameChanged should update state', () {
      controller.onNameChanged('New Name');
      expect(controller.state.name.value, 'New Name');
    });

    test('submit should upload image if present and then add product', () async {
      // Arrange
      final file = MockFile();
      controller.onImageChanged(file);
      controller.onNameChanged('Product');
      controller.onCodeChanged('CODE');
      controller.onPriceChanged('100');
      controller.onStockChanged('10');

      when(() => mockUploadRepository.uploadImage(file))
          .thenAnswer((_) async => 'http://image.url');
      when(() => mockProductRepository.addProduct(
            name: 'Product',
            code: 'CODE',
            price: 100.0,
            stock: 10,
            image: 'http://image.url',
            categoryId: any(named: 'categoryId'),
            tags: any(named: 'tags'),
            status: any(named: 'status'),
            description: any(named: 'description'),
          )).thenAnswer((_) async => const Either.right(null));
      
      // Fixed: Using thenAnswer for Future<void> return types
      when(() => mockAddProductNavigator.showSuccessSnackBar(message: any(named: 'message')))
          .thenAnswer((_) async => null);
      when(() => mockAddProductNavigator.pop(any())).thenAnswer((_) async => null);

      // Act
      await controller.submit();

      // Assert
      expect(controller.state.status.value, LoadStatus.success);
    });

    test('submit should fail if image upload fails', () async {
      // Arrange
      final file = MockFile();
      controller.onImageChanged(file);
      when(() => mockUploadRepository.uploadImage(file))
          .thenAnswer((_) async => null);
      when(() => mockAddProductNavigator.showErrorDialog(message: any(named: 'message')))
          .thenAnswer((_) async => null);

      // Act
      await controller.submit();

      // Assert
      expect(controller.state.status.value, LoadStatus.failure);
    });
  });
}
