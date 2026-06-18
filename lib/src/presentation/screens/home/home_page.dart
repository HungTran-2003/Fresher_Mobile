import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_circular_process_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_app/src/presentation/widgets/inputs/menu/app_filter_dropdown.dart';
import 'package:crud_app/src/presentation/screens/home/widgets/product_card.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'home_cubit.dart';
import 'home_navigator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) {
        final navigator = HomeNavigator(context);
        return HomeCubit(
          navigator: navigator,
          productRepository: context.read<ProductRepository>(),
        )..init();
      },
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeCubit>().loadProducts(isRefresh: false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchInput(context),
            _buildFilters(context),
            Expanded(child: _buildProductsList(context)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(context.s.addProduct)));
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
        onChanged: (val) => context.read<HomeCubit>().searchProducts(val),
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
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, current) =>
          prev.filterCategoryId != current.filterCategoryId ||
          prev.filterStatus != current.filterStatus ||
          prev.sortFilter != current.sortFilter ||
          prev.categories != current.categories,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                // Category Filter
                AppFilterDropdown<int?>(
                  value: state.filterCategoryId,
                  hint: context.s.category,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(context.s.allCategories),
                    ),
                    ...state.categories.map(
                      (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
                    ),
                  ],
                  onChanged: (val) =>
                      context.read<HomeCubit>().filterProducts(categoryId: val),
                ),
                const SizedBox(width: 8.0),
                // Status Filter
                AppFilterDropdown<ProductStatusFilter>(
                  value: state.filterStatus,
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
                    if (val != null)
                      context.read<HomeCubit>().filterProducts(status: val);
                  },
                ),
                const SizedBox(width: 8.0),
                // Sort options
                AppFilterDropdown<ProductSortFilter>(
                  value: state.sortFilter,
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
                    if (val != null)
                      context.read<HomeCubit>().filterProducts(sort: val);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsList(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, current) =>
          prev.products != current.products ||
          prev.isProductsLoading != current.isProductsLoading ||
          prev.isLoadMoreLoading != current.isLoadMoreLoading,
      builder: (context, state) {
        if (state.isProductsLoading && state.products.isEmpty) {
          return _buildLoadingState(context);
        }

        if (state.products.isEmpty) {
          return _buildEmptyState(context);
        }

        return _buildSuccessState(context, state);
      },
    );
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

  Widget _buildSuccessState(BuildContext context, HomeState state) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().loadProducts(isRefresh: true),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: state.products.length + (state.isLoadMoreLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < state.products.length) {
            return ProductCard(product: state.products[index]);
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

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.s.failedToLoadProducts),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              this.context.read<HomeCubit>().clearError();
            },
            child: Text(context.s.closeButton),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              this.context.read<HomeCubit>().clearError();
              this.context.read<HomeCubit>().loadProducts(isRefresh: true);
            },
            child: Text(context.s.tryAgain),
          ),
        ],
      ),
    ).then((_) {
      if (mounted) {
        context.read<HomeCubit>().clearError();
      }
    });
  }
}
