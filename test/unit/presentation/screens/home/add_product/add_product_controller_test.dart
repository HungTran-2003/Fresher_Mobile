import 'dart:io';
import 'package:crud_app/src/domain/usecases/product/add_product_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_categories_use_case.dart';
import 'package:crud_app/src/domain/usecases/upload/upload_image_use_case.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_controller.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';

class MockAddProductUseCase extends Mock implements AddProductUseCase {}

class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}

class MockUploadImageUseCase extends Mock implements UploadImageUseCase {}

class MockAddProductNavigator extends Mock implements AddProductNavigator {}

class MockFile extends Mock implements File {}

void main() {
  late AddProductController controller;
  late MockAddProductUseCase mockAddProductUseCase;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockUploadImageUseCase mockUploadImageUseCase;
  late MockAddProductNavigator mockAddProductNavigator;

  setUpAll(() {
    registerFallbackValue(AddProductParams(
      name: '',
      code: '',
      price: 0,
      stock: 0,
    ));
  });

  setUp(() {
    mockAddProductUseCase = MockAddProductUseCase();
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockUploadImageUseCase = MockUploadImageUseCase();
    mockAddProductNavigator = MockAddProductNavigator();

    controller = AddProductController(
      addProductUseCase: mockAddProductUseCase,
      getCategoriesUseCase: mockGetCategoriesUseCase,
      uploadImageUseCase: mockUploadImageUseCase,
      navigator: mockAddProductNavigator,
    );
  });

  group('AddProductController', () {
    test('onNameChanged should update state', () {
      controller.onNameChanged('New Name');
      expect(controller.state.name.value, 'New Name');
    });

    test('submit should upload image if present and then add product',
        () async {
      // Arrange
      final file = MockFile();
      controller.onImageChanged(file);
      controller.onNameChanged('Product');
      controller.onCodeChanged('CODE');
      controller.onPriceChanged('100');
      controller.onStockChanged('10');

      when(() => mockUploadImageUseCase.call(file)).thenAnswer(
        (_) async => 'http://image.url',
      );
      when(() => mockAddProductUseCase.call(any())).thenAnswer(
        (_) async => const Either.right(null),
      );

      // Fixed: Using thenAnswer for Future<void> return types
      when(
        () => mockAddProductNavigator.showSuccessSnackBar(
          message: any(named: 'message'),
        ),
      ).thenAnswer((_) async => null);
      when(() => mockAddProductNavigator.pop(any())).thenAnswer(
        (_) async => null,
      );

      // Act
      await controller.submit();

      // Assert
      expect(controller.state.status.value, LoadStatus.success);
    });

    test('submit should fail if image upload fails', () async {
      // Arrange
      final file = MockFile();
      controller.onImageChanged(file);
      when(() => mockUploadImageUseCase.call(file)).thenAnswer(
        (_) async => null,
      );
      when(
        () => mockAddProductNavigator.showErrorDialog(
          message: any(named: 'message'),
        ),
      ).thenAnswer((_) async => null);

      // Act
      await controller.submit();

      // Assert
      expect(controller.state.status.value, LoadStatus.failure);
    });
  });
}
