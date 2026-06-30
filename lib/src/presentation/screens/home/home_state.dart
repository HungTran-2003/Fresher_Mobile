import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_sort_filter.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:get/get.dart';

/// `true` class represents the state of the home screen.
class HomeState {
  final status = LoadStatus.initial.obs;
  final products = <ProductEntity>[].obs;
  final categories = <CategoryEntity>[].obs;
  final productStatus = LoadStatus.initial.obs;
  final loadMoreStatus = LoadStatus.initial.obs;
  final errorLoadProduct = ''.obs;
  final currentPage = 1.obs;
  final hasReachedMax = false.obs;
  final searchQuery = ''.obs;
  final filterCategoryId = RxnInt();
  final filterStatus = ProductStatusFilter.all.obs;
  final sortFilter = ProductSortFilter.defaultSort.obs;
  final isOffline = false.obs;
  final isRemotePrioritized = false.obs;
}
