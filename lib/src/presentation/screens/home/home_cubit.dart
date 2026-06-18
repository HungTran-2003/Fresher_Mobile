import 'dart:async';

import 'package:crud_app/src/data/models/product/product_model.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product/category_model.dart';
import 'home_navigator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;
  final ProductRepository _productRepository;
  Timer? _searchDebounceTimer;

  HomeCubit({
    required this.navigator,
    required ProductRepository productRepository,
  }) : _productRepository = productRepository,
       super(const HomeState());

  Future<void> init() async {
    await Future.wait([fetchCategories(), loadProducts(isRefresh: true)]);
  }

  Future<void> fetchCategories() async {
    final result = await _productRepository.getCategories();
    result.foldResult(
      onError: (e) => debugPrint('HomeCubit: Failed to fetch categories: $e'),
      onSuccess: (categories) => emit(state.copyWith(categories: categories)),
    );
  }

  /// Refreshes or loads more products based on current filters and pagination.
  Future<void> loadProducts({bool isRefresh = true}) async {
    if (!isRefresh &&
        (state.hasReachedMax ||
            state.isProductsLoading ||
            state.isLoadMoreLoading))
      return;

    emit(
      state.copyWith(
        currentPage: isRefresh ? 1 : state.currentPage,
        hasReachedMax: isRefresh ? false : state.hasReachedMax,
        isProductsLoading: isRefresh,
        isLoadMoreLoading: !isRefresh,
        productsError: null,
        products: isRefresh ? [] : state.products,
      ),
    );

    await _fetchProductsData(
      page: isRefresh ? 1 : state.currentPage + 1,
      isRefresh: isRefresh,
    );
  }

  /// Handles search query updates with a 300ms debounce.
  void searchProducts(String query) {
    emit(state.copyWith(searchQuery: query));

    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      loadProducts(isRefresh: true);
    });
  }

  /// Updates filter criteria and refreshes the product list.
  void filterProducts({
    int? categoryId,
    ProductStatusFilter? status,
    ProductSortFilter? sort,
  }) {
    emit(
      state.copyWith(
        filterCategoryId: categoryId ?? state.filterCategoryId,
        filterStatus: status ?? state.filterStatus,
        sortFilter: sort ?? state.sortFilter,
      ),
    );
    loadProducts(isRefresh: true);
  }

  /// Clears the error state.
  void clearError() {
    emit(state.copyWith(productsError: null));
  }

  /// Internal method to fetch, filter, and sort products.
  Future<void> _fetchProductsData({
    required int page,
    required bool isRefresh,
  }) async {
    final result = await _productRepository.getProducts(
      page: page,
      limit: 10,
      search: state.searchQuery.trim().isEmpty
          ? null
          : state.searchQuery.trim(),
      categoryId: state.filterCategoryId,
    );

    result.foldResult(
      onError: (e) {
        emit(
          state.copyWith(
            isProductsLoading: false,
            isLoadMoreLoading: false,
            productsError: e.toString(),
          ),
        );
        navigator.showErrorDialog(message: e.message);
      },
      onSuccess: (response) {
        final rawProducts = response.data;
        final hasReachedMax = rawProducts.length < 10;
        final processedProducts = _processProducts(
          rawProducts,
          isRefresh: isRefresh,
        );

        emit(
          state.copyWith(
            products: processedProducts,
            currentPage: page,
            hasReachedMax: hasReachedMax,
            isProductsLoading: false,
            isLoadMoreLoading: false,
          ),
        );
      },
    );
  }

  /// Processes raw products by applying local filters and sorting.
  List<ProductModel> _processProducts(
    List<ProductModel> rawProducts, {
    required bool isRefresh,
  }) {
    final filtered = _applyLocalFilters(rawProducts);
    final combined = isRefresh ? filtered : [...state.products, ...filtered];
    return _sortProducts(combined);
  }

  /// Filters products locally based on status.
  List<ProductModel> _applyLocalFilters(List<ProductModel> products) {
    if (state.filterStatus == ProductStatusFilter.all) return products;
    return products.where((p) => p.status == state.filterStatus.value).toList();
  }

  /// Sorts products locally based on the selected sort criteria.
  List<ProductModel> _sortProducts(List<ProductModel> products) {
    return List<ProductModel>.from(products)..sort((a, b) {
      final filter = state.sortFilter;
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

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }
}
