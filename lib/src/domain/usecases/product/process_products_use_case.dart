import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';

class ProcessProductsUseCase {
  List<ProductEntity> call(ProcessProductsParams params) {
    final filtered = _applyLocalFilters(params.rawProducts, params.filterStatus);
    
    final combined = params.isRefresh 
        ? filtered 
        : [...params.currentProducts, ...filtered];
        
    return _sortProducts(combined, params.sortFilter);
  }

  List<ProductEntity> _applyLocalFilters(
    List<ProductEntity> productsList, 
    ProductStatusFilter filterStatus,
  ) {
    if (filterStatus == ProductStatusFilter.all) {
      return productsList;
    }
    return productsList
        .where((p) => p.status == filterStatus.value)
        .toList();
  }

  List<ProductEntity> _sortProducts(
    List<ProductEntity> productsList, 
    ProductSortFilter sortFilter,
  ) {
    return List<ProductEntity>.from(productsList)..sort((a, b) {
      return switch (sortFilter) {
        ProductSortFilter.nameAsc => a.name.toLowerCase().compareTo(
          b.name.toLowerCase(),
        ),
        ProductSortFilter.nameDesc => b.name.toLowerCase().compareTo(
          a.name.toLowerCase(),
        ),
        ProductSortFilter.priceAsc => a.price.compareTo(b.price),
        ProductSortFilter.priceDesc => b.price.compareTo(a.price),
        ProductSortFilter.stockAsc => a.stock.compareTo(b.stock),
        ProductSortFilter.stockDesc => b.stock.compareTo(a.stock),
        ProductSortFilter.updatedAtDesc => b.updatedAt.compareTo(a.updatedAt),
        ProductSortFilter.defaultSort => 0,
      };
    });
  }
}

class ProcessProductsParams {
  final List<ProductEntity> rawProducts;
  final List<ProductEntity> currentProducts;
  final ProductStatusFilter filterStatus;
  final ProductSortFilter sortFilter;
  final bool isRefresh;

  ProcessProductsParams({
    required this.rawProducts,
    required this.currentProducts,
    required this.filterStatus,
    required this.sortFilter,
    required this.isRefresh,
  });
}
