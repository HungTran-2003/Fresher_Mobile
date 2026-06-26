import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/usecases/product/process_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProcessProductsUseCase useCase;

  setUp(() {
    useCase = ProcessProductsUseCase();
  });

  final tProducts = [
    ProductEntity(
      id: 1,
      name: 'B Product',
      code: 'P1',
      price: 100,
      stock: 10,
      status: 1,
      createdAt: '',
      updatedAt: '2023-01-01',
    ),
    ProductEntity(
      id: 2,
      name: 'A Product',
      code: 'P2',
      price: 50,
      stock: 20,
      status: 0,
      createdAt: '',
      updatedAt: '2023-01-02',
    ),
  ];

  test('should sort products by name ascending', () {
    // arrange
    final params = ProcessProductsParams(
      rawProducts: tProducts,
      currentProducts: [],
      filterStatus: ProductStatusFilter.all,
      sortFilter: ProductSortFilter.nameAsc,
      isRefresh: true,
    );

    // act
    final result = useCase(params);

    // assert
    expect(result[0].name, 'A Product');
    expect(result[1].name, 'B Product');
  });

  test('should filter products by status', () {
    // arrange
    final params = ProcessProductsParams(
      rawProducts: tProducts,
      currentProducts: [],
      filterStatus: ProductStatusFilter.inactive,
      sortFilter: ProductSortFilter.defaultSort,
      isRefresh: true,
    );

    // act
    final result = useCase(params);

    // assert
    expect(result.length, 1);
    expect(result[0].id, 2);
  });

  test('should combine current products and raw products when isRefresh is false', () {
     // arrange
    final params = ProcessProductsParams(
      rawProducts: [tProducts[0]],
      currentProducts: [tProducts[1]],
      filterStatus: ProductStatusFilter.all,
      sortFilter: ProductSortFilter.defaultSort,
      isRefresh: false,
    );

    // act
    final result = useCase(params);

    // assert
    expect(result.length, 2);
    expect(result.contains(tProducts[0]), true);
    expect(result.contains(tProducts[1]), true);
  });
}
