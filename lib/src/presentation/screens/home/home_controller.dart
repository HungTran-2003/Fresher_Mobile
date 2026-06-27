import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/usecases/product/delete_product_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_categories_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_local_products_use_case.dart';
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
  final GetRemoteProductsUseCase _getRemoteProductsUseCase;
  final GetLocalProductsUseCase _getLocalProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final ProcessProductsUseCase _processProductsUseCase;
  final HomeNavigator navigator;
  final state = HomeState();
  StreamSubscription? _connectivitySubscription;

  HomeController({
    required GetRemoteProductsUseCase getRemoteProductsUseCase,
    required GetLocalProductsUseCase getLocalProductsUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required DeleteProductUseCase deleteProductUseCase,
    required ProcessProductsUseCase processProductsUseCase,
    required this.navigator,
  }) : _getRemoteProductsUseCase = getRemoteProductsUseCase,
       _getLocalProductsUseCase = getLocalProductsUseCase,
       _getCategoriesUseCase = getCategoriesUseCase,
       _deleteProductUseCase = deleteProductUseCase,
       _processProductsUseCase = processProductsUseCase;

  String _lastSearchQuery = '';

  @override
  void onInit() {
    super.onInit();
    init();
    _listenToConnectivity();
    debounce(state.searchQuery, (query) {
      if (_lastSearchQuery != query) {
        _lastSearchQuery = query;
        loadProducts(isRefresh: true);
      }
    }, time: const Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  void _listenToConnectivity() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((results) {
          final isConnected = !results.contains(ConnectivityResult.none);
          final wasOffline = state.isOffline.value;
          state.isOffline.value = !isConnected;

          if (isConnected && wasOffline) {
            navigator.showInfoSnackBar(
              message: 'Đã kết nối lại. Đang cập nhật dữ liệu...',
            );
            loadProducts(isRefresh: true);
          }
        });
  }

  bool _checkConnectivity() {
    if (state.isOffline.value) {
      navigator.showErrorSnackBar(
        message: 'Cần có kết nối mạng để thực hiện chức năng này.',
      );
      return false;
    }
    return true;
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
    if (!_checkConnectivity()) return;
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

  void goToAddProduct() {
    if (!_checkConnectivity()) return;
    navigator.toAddProduct();
  }

  void goToProductDetail(ProductEntity product) {
    if (!_checkConnectivity()) return;
    navigator.pushNamed(
      AppRouters.productDetail,
      arguments: product,
    );
  }

  Future<void> _fetchProductsData({
    required int page,
    required bool isRefresh,
  }) async {
    final result = state.isOffline.value 
      ? await _getLocalProductsUseCase(
          GetLocalProductsParams(
            search: state.searchQuery.value.isEmpty ? null : state.searchQuery.value,
            categoryId: state.filterCategoryId.value,
          ),
        )
      : await _getRemoteProductsUseCase(
          GetProductsParams(
            page: page,
            limit: 10,
            search: state.searchQuery.value.isEmpty ? null : state.searchQuery.value,
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
