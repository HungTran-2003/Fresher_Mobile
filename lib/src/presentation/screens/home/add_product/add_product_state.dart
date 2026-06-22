import 'dart:io';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:get/get.dart';

class AddProductState {
  final status = LoadStatus.initial.obs;
  final name = ''.obs;
  final code = ''.obs;
  final price = ''.obs;
  final stock = ''.obs;
  final category = Rxn<CategoryEntity>();
  final categories = <CategoryEntity>[].obs;
  final tags = <String>[].obs;
  final statusFilter = ProductStatusFilter.active.obs;
  final description = ''.obs;
  final imageFile = Rxn<File>();
  final isFirstSubmit = false.obs;
  final existingCodes = <String>{}.obs;
  final error = RxnString();
}
