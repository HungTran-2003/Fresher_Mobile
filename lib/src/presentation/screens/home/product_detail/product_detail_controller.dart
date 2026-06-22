import 'dart:io';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/core/exceptions/app_error_key.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/src/data/services/cloudinary/cloudinary_service.dart';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:get/get.dart';
import '../add_product/add_product_navigator.dart';
import 'product_detail_state.dart';

class ProductDetailController extends GetxController {
  final ProductRepository _productRepository;
  final AddProductNavigator navigator;
  final ProductEntity? initialProduct;
  late final ProductEntity product;
  final state = ProductDetailState();

  ProductDetailController({
    required ProductRepository productRepository,
    required this.navigator,
    this.initialProduct,
  }) : _productRepository = productRepository;

  @override
  void onInit() {
    super.onInit();
    product = initialProduct ?? Get.arguments as ProductEntity;
    
    state.name.value = product.name;
    state.code.value = product.code;
    state.price.value = product.price.toString();
    state.stock.value = product.stock.toString();
    state.category.value = product.category;
    state.statusFilter.value = ProductStatusFilter.fromValue(product.status);
    state.description.value = product.description ?? '';
    state.imageUrl.value = product.image;
    
    init();
  }

  Future<void> init() async {
    final result = await _productRepository.getCategories();
    result.foldResult(
      onError: (e) => navigator.showErrorDialog(message: e.message),
      onSuccess: (list) => state.categories.assignAll(list),
    );
  }

  void onNameChanged(String value) => state.name.value = value;
  void onCodeChanged(String value) {
    state.code.value = value;
    state.existingCodes.clear();
  }
  void onPriceChanged(String value) => state.price.value = value;
  void onStockChanged(String value) => state.stock.value = value;
  void onCategoryChanged(CategoryEntity? value) => state.category.value = value;
  void onStatusChanged(ProductStatusFilter value) => state.statusFilter.value = value;
  void onDescriptionChanged(String value) => state.description.value = value;
  void onImageChanged(File? file) {
    state.imageFile.value = file;
    state.imageUrl.value = null;
  }
  void removeImage() {
    state.imageFile.value = null;
    state.imageUrl.value = null;
  }

  void onTagsChanged(String value) {
    final list = value
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    state.tags.assignAll(list);
  }

  Future<void> updateProduct() async {
    state.status.value = LoadStatus.loading;
    state.isFirstSubmit.value = true;

    String? finalImageUrl = state.imageUrl.value;
    if (state.imageFile.value != null) {
      finalImageUrl = await CloudinaryService.uploadImage(state.imageFile.value!);
      if (finalImageUrl == null) {
        state.status.value = LoadStatus.failure;
        navigator.showErrorDialog(message: S.current.failedToUploadImage);
        return;
      }
    }

    final result = await _productRepository.updateProduct(
      id: product.id,
      name: state.name.value,
      code: state.code.value,
      price: double.tryParse(state.price.value) ?? 0.0,
      stock: int.tryParse(state.stock.value) ?? 0,
      categoryId: state.category.value?.id,
      status: state.statusFilter.value.value,
      tags: state.tags,
      description: state.description.value,
      image: finalImageUrl,
    );

    result.foldResult(
      onError: (e) {
        if (e.errorKey == AppErrorKey.productAlreadyExists) {
          state.existingCodes.add(state.code.value);
        }
        state.status.value = LoadStatus.failure;
        navigator.showErrorDialog(message: e.message);
      },
      onSuccess: (_) {
        state.status.value = LoadStatus.success;
        navigator.showSuccessSnackBar(message: S.current.productUpdateSuccess);
        navigator.pop(true);
      },
    );
  }
}
