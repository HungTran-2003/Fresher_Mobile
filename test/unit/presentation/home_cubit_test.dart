import 'package:bloc_test/bloc_test.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/screens/home/home_cubit.dart';
import 'package:crud_app/src/presentation/screens/home/home_navigator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockHomeNavigator extends Mock implements HomeNavigator {}

void main() {
  late HomeCubit homeCubit;
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
    homeCubit = HomeCubit(
      productRepository: productRepository,
      navigator: homeNavigator,
    );

    // Initialize localization for S.current
    await S.load(const Locale('en'));

    // Stub navigator methods
    when(() => homeNavigator.showSuccessSnackBar(message: any(named: 'message')))
        .thenAnswer((_) async {});
    when(() => homeNavigator.pop(any())).thenAnswer((_) async {});

    registerFallbackValue(1);
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit - Read & Delete', () {
    test('initial state is correct', () {
      expect(homeCubit.state, const HomeState());
    });

    blocTest<HomeCubit, HomeState>(
      'loadProducts emits success state with products when successful',
      build: () {
        when(() => productRepository.getProducts(
              page: any(named: 'page'),
              limit: any(named: 'limit'),
              search: any(named: 'search'),
              categoryId: any(named: 'categoryId'),
            )).thenAnswer((_) async => const Right(tProducts));
        return homeCubit;
      },
      act: (cubit) => cubit.loadProducts(isRefresh: true),
      expect: () => [
        isA<HomeState>().having((s) => s.isProductsLoading, 'isProductsLoading', true),
        isA<HomeState>()
            .having((s) => s.isProductsLoading, 'isProductsLoading', false)
            .having((s) => s.products, 'products', tProducts),
      ],
      verify: (_) {
        verify(() => productRepository.getProducts(page: 1, limit: 10)).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'fetchCategories emits state with categories when successful',
      build: () {
        when(() => productRepository.getCategories())
            .thenAnswer((_) async => const Right([]));
        return homeCubit;
      },
      act: (cubit) => cubit.fetchCategories(),
      expect: () => [
        isA<HomeState>().having((s) => s.categories, 'categories', isEmpty),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'deleteProduct removes product from list and emits success',
      seed: () => const HomeState(products: tProducts),
      build: () {
        when(() => productRepository.deleteProduct(any()))
            .thenAnswer((_) async => const Right(null));
        return homeCubit;
      },
      act: (cubit) => cubit.deleteProduct(1),
      expect: () => [
        isA<HomeState>().having((s) => s.status, 'status', LoadStatus.loading),
        isA<HomeState>()
            .having((s) => s.status, 'status', LoadStatus.success)
            .having((s) => s.products, 'products', isEmpty),
      ],
      verify: (_) {
        verify(() => productRepository.deleteProduct(1)).called(1);
        verify(() => homeNavigator.showSuccessSnackBar(message: any(named: 'message'))).called(1);
      },
    );
  });
}
