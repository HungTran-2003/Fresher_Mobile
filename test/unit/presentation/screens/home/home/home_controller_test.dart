import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/screens/home/home_controller.dart';
import 'package:crud_app/src/presentation/screens/home/home_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockHomeNavigator extends Mock implements HomeNavigator {}

void main() {
  late HomeController controller;
  late MockProductRepository mockProductRepository;
  late MockHomeNavigator mockHomeNavigator;

  setUp(() {
    mockProductRepository = MockProductRepository();
    mockHomeNavigator = MockHomeNavigator();
    
    controller = HomeController(
      productRepository: mockProductRepository,
      navigator: mockHomeNavigator,
    );
  });

  group('HomeController', () {
    test('init should fetch categories and products', () async {
      // Arrange
      when(() => mockProductRepository.getCategories())
          .thenAnswer((_) async => const Either.right([]));
      when(() => mockProductRepository.getProducts(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
            categoryId: any(named: 'categoryId'),
          )).thenAnswer((_) async => const Either.right([]));

      // Act
      await controller.init();

      // Assert
      expect(controller.state.productStatus.value, LoadStatus.success);
    });

    test('deleteProduct should call repository and update status', () async {
      // Arrange
      final product = ProductEntity(
        id: 1,
        status: 1,
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        name: 'Test',
        code: 'T1',
        price: 10.0,
        stock: 5,
      );
      controller.state.products.add(product);
      when(() => mockProductRepository.deleteProduct(1))
          .thenAnswer((_) async => const Either.right(null));
      
      // Use thenAnswer for Future<void>
      when(() => mockHomeNavigator.showSuccessSnackBar(message: any(named: 'message')))
          .thenAnswer((_) async => null);
      
      // Act
      await controller.deleteProduct(1);

      // Assert
      expect(controller.state.status.value, LoadStatus.success);
      verify(() => mockProductRepository.deleteProduct(1)).called(1);
    });
  });
}
