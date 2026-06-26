import 'dart:async';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/usecases/product/delete_product_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_categories_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/process_products_use_case.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'home_navigator.dart';
import 'home_state.dart';

class HomeController extends GetxController {
  final GetProductsUseCase _getProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final ProcessProductsUseCase _processProductsUseCase;
  final HomeNavigator navigator;
  final state = HomeState();

  HomeController({
    required GetProductsUseCase getProductsUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required DeleteProductUseCase deleteProductUseCase,
    required ProcessProductsUseCase processProductsUseCase,
    required this.navigator,
  }) : _getProductsUseCase = getProductsUseCase,
       _getCategoriesUseCase = getCategoriesUseCase,
       _deleteProductUseCase = deleteProductUseCase,
       _processProductsUseCase = processProductsUseCase;

  String _lastSearchQuery = '';

  @override
  void onInit() {
    super.onInit();
    init();
    debounce(state.searchQuery, (query) {
      if (_lastSearchQuery != query) {
        _lastSearchQuery = query;
        loadProducts(isRefresh: true);
      }
    }, time: const Duration(milliseconds: 300));
  }

  Future<void> init() async {
    await Future.wait([fetchCategories(), loadProducts(isRefresh: true)]);
  }

  Future<void> fetchCategories() async {
    final result = await _getCategoriesUseCase(NoParams());
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
    final value = query.trim();
    if (value == state.searchQuery.value) {
      return;
    }
    state.searchQuery.value = value;
  }

  void filterProducts({
    int? categoryId,
    ProductStatusFilter? status,
    ProductSortFilter? sort,
  }) {
    var hasChanged = false;

    if (categoryId != state.filterCategoryId.value) {
      state.filterCategoryId.value = categoryId;
      hasChanged = true;
    }

    if (status != null && status != state.filterStatus.value) {
      state.filterStatus.value = status;
      hasChanged = true;
    }

    if (sort != null && sort != state.sortFilter.value) {
      state.sortFilter.value = sort;
      hasChanged = true;
    }

    if (hasChanged) {
      loadProducts(isRefresh: true);
    }
  }

  Future<void> deleteProduct(int id) async {
    state.status.value = LoadStatus.loading;

    final result = await _deleteProductUseCase(id);

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
    final result = await _getProductsUseCase(
      GetProductsParams(
        page: page,
        limit: 10,
        search: state.searchQuery.value.isEmpty
            ? null
            : state.searchQuery.value,
        categoryId: state.filterCategoryId.value,
      ),
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
        final List<ProductEntity> processed = _processProductsUseCase(
          ProcessProductsParams(
            rawProducts: response,
            currentProducts: state.products,
            filterStatus: state.filterStatus.value,
            sortFilter: state.sortFilter.value,
            isRefresh: isRefresh,
          ),
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
}
