part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus status;
  final int activeTab;

  // Products pagination & data
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final bool isProductsLoading;
  final bool isLoadMoreLoading;
  final int currentPage;
  final bool hasReachedMax;

  // Search & Filter & Sort state
  final String searchQuery;
  final int? filterCategoryId;
  final ProductStatusFilter filterStatus;
  final ProductSortFilter sortFilter;

  const HomeState({
    this.status = LoadStatus.initial,
    this.activeTab = 0,
    this.products = const [],
    this.categories = const [],
    this.isProductsLoading = false,
    this.isLoadMoreLoading = false,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.searchQuery = '',
    this.filterCategoryId,
    this.filterStatus = ProductStatusFilter.all,
    this.sortFilter = ProductSortFilter.defaultSort,
  });

  HomeState copyWith({
    LoadStatus? status,
    int? activeTab,
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    bool? isProductsLoading,
    bool? isLoadMoreLoading,
    String? productsError,
    int? currentPage,
    bool? hasReachedMax,
    String? searchQuery,
    int? filterCategoryId,
    ProductStatusFilter? filterStatus,
    ProductSortFilter? sortFilter,
  }) {
    return HomeState(
      status: status ?? this.status,
      activeTab: activeTab ?? this.activeTab,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      isLoadMoreLoading: isLoadMoreLoading ?? this.isLoadMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
      filterCategoryId: filterCategoryId ?? this.filterCategoryId,
      filterStatus: filterStatus ?? this.filterStatus,
      sortFilter: sortFilter ?? this.sortFilter,
    );
  }

  @override
  List<Object?> get props => [
        status,
        activeTab,
        products,
        categories,
        isProductsLoading,
        isLoadMoreLoading,
        currentPage,
        hasReachedMax,
        searchQuery,
        filterCategoryId,
        filterStatus,
        sortFilter,
      ];
}
