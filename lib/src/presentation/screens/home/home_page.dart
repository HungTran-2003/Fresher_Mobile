import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_circular_process_indicator.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud_app/src/presentation/widgets/inputs/menu/app_filter_dropdown.dart';
import 'package:crud_app/src/presentation/screens/home/widgets/product_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeChildPage();
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late final ScrollController _scrollController;
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _controller = Get.find<HomeController>();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _controller.loadProducts(isRefresh: false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _confirmDelete(int id) async {
    final action = await AppDialog.show(
      context: context,
      dialogType: DialogType.errorConfirmation,
      titleText: context.s.deleteProductConfirmTitle,
      messageText: context.s.deleteProductConfirmMessage,
      confirmButtonText: context.s.deleteButton,
      declineButtonText: context.s.cancelButtonLabel,
    );

    if (action == DialogAction.confirmed) {
      await _controller.deleteProduct(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.s.productManagement,
          style: context.textThemes.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildSearchInput(context),
                _buildFilters(context),
                Expanded(child: _buildProductsList(context)),
              ],
            ),
          ),
          Obx(() {
            if (_controller.state.status.value == LoadStatus.loading) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppLoadingOverlay.show(context);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppLoadingOverlay.hide();
              });
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await _controller.navigator.pushNamed(
            AppRouters.addProduct,
          );
          if (result == true) {
            _controller.loadProducts(isRefresh: true);
          }
        },
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
      child: TextField(
        onChanged: (val) => _controller.searchProducts(val),
        decoration: InputDecoration(
          hintText: context.s.searchProductHint,
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: context.colors.surfaceContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              // Category Filter
              AppFilterDropdown<int?>(
                value: _controller.state.filterCategoryId.value,
                hint: context.s.category,
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text(context.s.allCategories),
                  ),
                  ..._controller.state.categories.map(
                    (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
                  ),
                ],
                onChanged: (val) =>
                    _controller.filterProducts(categoryId: val),
              ),
              const SizedBox(width: 8.0),
              // Status Filter
              AppFilterDropdown<ProductStatusFilter>(
                value: _controller.state.filterStatus.value,
                hint: context.s.status,
                items: ProductStatusFilter.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.getLabel(context)),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    _controller.filterProducts(status: val);
                  }
                },
              ),
              const SizedBox(width: 8.0),
              // Sort options
              AppFilterDropdown<ProductSortFilter>(
                value: _controller.state.sortFilter.value,
                hint: context.s.sortBy,
                items: ProductSortFilter.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.getLabel(context)),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    _controller.filterProducts(sort: val);
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProductsList(BuildContext context) {
    return Obx(() {
      if (_controller.state.isProductsLoading.value && _controller.state.products.isEmpty) {
        return _buildLoadingState(context);
      }

      if (_controller.state.products.isEmpty) {
        return _buildEmptyState(context);
      }

      return _buildSuccessState(context);
    });
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: AppCircularProgressIndicator(valueColor: context.colors.primary),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(context.s.noProductsFound, style: context.textThemes.body16Semi),
          const SizedBox(height: 8),
          Text(
            context.s.adjustSearchOrFilters,
            style: context.textThemes.des12Re,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _controller.loadProducts(isRefresh: true),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: _controller.state.products.length + (_controller.state.isLoadMoreLoading.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _controller.state.products.length) {
            final product = _controller.state.products[index];
            return Slidable(
              key: ValueKey(product.id),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) => _confirmDelete(product.id),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: context.s.deleteButton,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () async {
                  final result = await _controller.navigator.pushNamed(
                    AppRouters.productDetail,
                    arguments: product,
                  );
                  if (result == true) {
                    _controller.loadProducts(isRefresh: true);
                  }
                },
                onLongPress: () => _confirmDelete(product.id),
                child: ProductCard(product: product),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: AppCircularProgressIndicator(
                  valueColor: context.colors.primary,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
