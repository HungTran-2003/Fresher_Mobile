import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_circular_process_indicator.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_app/src/presentation/widgets/inputs/menu/app_filter_dropdown.dart';
import 'package:crud_app/src/presentation/screens/home/widgets/product_card.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_dialog.dart';
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
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _cubit = context.read<HomeCubit>();
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
      await _cubit.deleteProduct(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (prev, current) => prev.status != current.status,
      listener: (context, state) {
        if (state.status == LoadStatus.loading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
      },
      child: Scaffold(
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
          onPressed: () async {
            final result = await _cubit.navigator.pushNamed(
              AppRouters.addProduct,
            );
            if (result == true) {
              if (context.mounted) {
                _cubit.loadProducts(isRefresh: true);
              }
            }
          },
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
      child: AppTextField(
        controller: TextEditingController(), // Note: Ideally should use a controller from Cubit or Local State
        onChanged: (val) => context.read<HomeCubit>().searchProducts(val),
        hintText: context.s.searchProductHint,
        prefixIcon: const Icon(Icons.search),
        backgroundColor: context.colors.surfaceContainer,
        borderRadius: 12.0,
        isFilled: true,
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
                      value: -1,
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
                    if (val != null) {
                      context.read<HomeCubit>().filterProducts(status: val);
                    }
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
                    if (val != null) {
                      context.read<HomeCubit>().filterProducts(sort: val);
                    }
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
            final product = state.products[index];
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
                  final result = await _cubit.navigator.pushNamed(
                    AppRouters.productDetail,
                    extra: product,
                  );
                  if (result == true) {
                    if (context.mounted) {
                      _cubit.loadProducts(isRefresh: true);
                    }
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
