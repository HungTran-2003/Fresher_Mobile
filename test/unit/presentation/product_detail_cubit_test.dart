import 'package:bloc_test/bloc_test.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_navigator.dart';
import 'package:crud_app/src/presentation/screens/home/product_detail/product_detail_cubit.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockAddProductNavigator extends Mock implements AddProductNavigator {}

void main() {
  late ProductDetailCubit productDetailCubit;
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
    productDetailCubit = ProductDetailCubit(
      productRepository: productRepository,
      product: tProduct,
      navigator: addProductNavigator,
    );

    // Initialize localization for S.current
    await S.load(const Locale('en'));

    // Stub navigator methods
    when(() => addProductNavigator.showSuccessSnackBar(message: any(named: 'message')))
        .thenAnswer((_) async {});
    when(() => addProductNavigator.pop(any())).thenAnswer((_) async {});
  });

  tearDown(() {
    productDetailCubit.close();
  });

  group('ProductDetailCubit - Update', () {
    blocTest<ProductDetailCubit, ProductDetailState>(
      'update emits success state when product updated successfully',
      seed: () => ProductDetailState(
        product: tProduct,
        name: 'Updated Name',
        code: 'P1',
        price: '150',
        stock: '20',
      ),
      build: () {
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
        return productDetailCubit;
      },
      act: (cubit) => cubit.update(),
      expect: () => [
        isA<ProductDetailState>().having((s) => s.status, 'status', LoadStatus.loading),
        isA<ProductDetailState>().having((s) => s.status, 'status', LoadStatus.success),
      ],
      verify: (_) {
        verify(() => productRepository.updateProduct(
              id: 1,
              name: 'Updated Name',
              code: 'P1',
              price: 150.0,
              stock: 20,
              categoryId: any(named: 'categoryId'),
              status: any(named: 'status'),
              tags: any(named: 'tags'),
              description: any(named: 'description'),
              image: any(named: 'image'),
            )).called(1);
        verify(() => addProductNavigator.showSuccessSnackBar(message: any(named: 'message'))).called(1);
        verify(() => addProductNavigator.pop(true)).called(1);
      },
    );
  });
}
