import 'dart:async';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'home_navigator.dart';
import 'home_state.dart';

class HomeController extends GetxController {
  final ProductRepository _productRepository;
  final HomeNavigator navigator;
  final state = HomeState();

  HomeController({
    required ProductRepository productRepository,
    required this.navigator,
  }) : _productRepository = productRepository;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await Future.wait([fetchCategories(), loadProducts(isRefresh: true)]);
  }

  Future<void> fetchCategories() async {
    final result = await _productRepository.getCategories();
    result.foldResult(
      onError: (e) =>
          debugPrint('HomeController: Failed to fetch categories: $e'),
      onSuccess: (list) => state.categories.assignAll(list),
    );
  }

  Future<void> loadProducts({bool isRefresh = true}) async {
    if (!isRefresh &&
        (state.hasReachedMax.value ||
            state.productStatus.value.isLoading ||
            state.loadMoreStatus.value.isLoading)) {
      return;
    }

    if (isRefresh) {
      state.currentPage.value = 1;
      state.hasReachedMax.value = false;
      state.productStatus.value = LoadStatus.loading;
      state.products.clear();
    } else {
      state.loadMoreStatus.value = LoadStatus.loading;
    }

    await _fetchProductsData(
      page: state.currentPage.value,
      isRefresh: isRefresh,
    );
  }

  void searchProducts(String query) {
    state.searchQuery.value = query.trim();
    debounce(state.searchQuery, (_){
      loadProducts(isRefresh: true);
    },
    time: const Duration(milliseconds: 300));
  }

  void filterProducts({
    int? categoryId,
    ProductStatusFilter? status,
    ProductSortFilter? sort,
  }) {
    if (categoryId != null || state.filterCategoryId.value != null) {
      state.filterCategoryId.value = categoryId;
    }
    if (status != null) state.filterStatus.value = status;
    if (sort != null) state.sortFilter.value = sort;

    loadProducts(isRefresh: true);
  }

  Future<void> deleteProduct(int id) async {
    state.status.value = LoadStatus.loading;

    final result = await _productRepository.deleteProduct(id);

    result.foldResult(
      onError: (e) {
        state.status.value = LoadStatus.failure;
        navigator.showErrorDialog(message: e.message);
      },
      onSuccess: (_) {
        state.products.removeWhere((p) => p.id == id);
        state.status.value = LoadStatus.success;
        navigator.showSuccessSnackBar(message: S.current.productDeletedSuccess);
      },
    );
  }

  Future<void> _fetchProductsData({
    required int page,
    required bool isRefresh,
  }) async {
    final result = await _productRepository.getProducts(
      page: page,
      limit: 10,
      search: state.searchQuery.value.isEmpty
          ? null
          : state.searchQuery.value,
      categoryId: state.filterCategoryId.value,
    );

    result.foldResult(
      onError: (e) {
        if (isRefresh) {
          state.productStatus.value = LoadStatus.failure;
          state.errorLoadProduct.value = e.message;
        } else {
          state.loadMoreStatus.value = LoadStatus.failure;
          navigator.showErrorDialog(message: e.message);
        }
      },
      onSuccess: (response) {
        final hasReached = response.length < 10;
        final List<ProductEntity> processed = _processProducts(
          response,
          isRefresh: isRefresh,
        );

        state.products.assignAll(processed);
        state.currentPage.value = page + (hasReached ? 0 : 1);
        state.hasReachedMax.value = hasReached;
        state.loadMoreStatus.value = LoadStatus.success;
        state.productStatus.value = LoadStatus.success;
        if (isRefresh) {
          state.errorLoadProduct.value = '';
        }
      },
    );
  }

  List<ProductEntity> _processProducts(
    List<ProductEntity> rawProducts, {
    required bool isRefresh,
  }) {
    final filtered = _applyLocalFilters(rawProducts);
    final combined = isRefresh ? filtered : [...state.products, ...filtered];
    return _sortProducts(combined);
  }

  List<ProductEntity> _applyLocalFilters(List<ProductEntity> productsList) {
    if (state.filterStatus.value == ProductStatusFilter.all) {
      return productsList;
    }
    return productsList
        .where((p) => p.status == state.filterStatus.value.value)
        .toList();
  }

  List<ProductEntity> _sortProducts(List<ProductEntity> productsList) {
    return List<ProductEntity>.from(productsList)..sort((a, b) {
      final filter = state.sortFilter.value;
      return switch (filter) {
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
