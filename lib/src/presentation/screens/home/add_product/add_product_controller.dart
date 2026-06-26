import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/core/exceptions/app_error_key.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/usecases/product/add_product_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/get_categories_use_case.dart';
import 'package:crud_app/src/domain/usecases/upload/upload_image_use_case.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:get/get.dart';
import 'add_product_navigator.dart';
import 'add_product_state.dart';
import 'dart:io';

class AddProductController extends GetxController {
  final AddProductUseCase _addProductUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final UploadImageUseCase _uploadImageUseCase;
  final AddProductNavigator navigator;
  final state = AddProductState();

  AddProductController({
    required AddProductUseCase addProductUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required UploadImageUseCase uploadImageUseCase,
    required this.navigator,
  }) : _addProductUseCase = addProductUseCase,
       _getCategoriesUseCase = getCategoriesUseCase,
       _uploadImageUseCase = uploadImageUseCase;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    final result = await _getCategoriesUseCase(NoParams());
    result.foldResult(
      onError: (e) => navigator.showErrorDialog(message: e.message),
      onSuccess: (list) => state.categories.assignAll(list),
    );
  }

  void onNameChanged(String value) => state.name.value = value;
  void onCodeChanged(String value) => state.code.value = value;
  void onPriceChanged(String value) => state.price.value = value;
  void onStockChanged(String value) => state.stock.value = value;
  void onCategoryChanged(CategoryEntity? value) => state.category.value = value;
  void onStatusChanged(ProductStatusFilter value) =>
      state.statusFilter.value = value;
  void onDescriptionChanged(String value) => state.description.value = value;
  void onImageChanged(File? file) => state.imageFile.value = file;
  void removeImage() => state.imageFile.value = null;

  void onTagsChanged(String value) {
    final list = value
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    state.tags.assignAll(list);
  }

  Future<void> submit() async {
    state.status.value = LoadStatus.loading;
    state.isFirstSubmit.value = true;

    String? imageUrl;
    if (state.imageFile.value != null) {
      imageUrl = await _uploadImageUseCase(state.imageFile.value!);
      if (imageUrl == null) {
        state.status.value = LoadStatus.failure;
        navigator.showErrorDialog(message: S.current.failedToUploadImage);
        return;
      }
    }

    final result = await _addProductUseCase(AddProductParams(
      name: state.name.value,
      code: state.code.value,
      price: double.tryParse(state.price.value) ?? 0.0,
      stock: int.tryParse(state.stock.value) ?? 0,
      categoryId: state.category.value?.id,
      tags: state.tags,
      status: state.statusFilter.value.value,
      description: state.description.value,
      image: imageUrl,
    ));

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
        navigator.showSuccessSnackBar(message: S.current.productAddedSuccess);
        navigator.pop(true);
      },
    );
  }
}
