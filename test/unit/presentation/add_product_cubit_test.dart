import 'package:bloc_test/bloc_test.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_cubit.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockAddProductNavigator extends Mock implements AddProductNavigator {}

void main() {
  late AddProductCubit addProductCubit;
  late MockProductRepository productRepository;
  late MockAddProductNavigator addProductNavigator;

  setUp(() async {
    productRepository = MockProductRepository();
    addProductNavigator = MockAddProductNavigator();
    addProductCubit = AddProductCubit(
      productRepository: productRepository,
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
    addProductCubit.close();
  });

  group('AddProductCubit - Create', () {
    blocTest<AddProductCubit, AddProductState>(
      'submit emits success state when product added successfully',
      seed: () => const AddProductState(
        name: 'New Product',
        code: 'NP1',
        price: '100',
        stock: '10',
      ),
      build: () {
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
        return addProductCubit;
      },
      act: (cubit) => cubit.submit(),
      expect: () => [
        isA<AddProductState>().having((s) => s.status, 'status', LoadStatus.loading),
        isA<AddProductState>().having((s) => s.status, 'status', LoadStatus.success),
      ],
      verify: (_) {
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
        verify(() => addProductNavigator.showSuccessSnackBar(message: any(named: 'message'))).called(1);
        verify(() => addProductNavigator.pop(true)).called(1);
      },
    );
  });
}
