import 'dart:io';

import 'package:crud_app/src/core/exceptions/app_error_key.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/data/services/cloudinary/cloudinary_service.dart';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository _productRepository;
  final AddProductNavigator navigator;

  ProductDetailCubit({
    required ProductRepository productRepository,
    required ProductEntity product,
    required this.navigator,
  })  : _productRepository = productRepository,
        super(ProductDetailState(
          product: product,
          name: product.name,
          code: product.code,
          price: product.price.toString(),
          stock: product.stock.toString(),
          category: product.category,
          statusFilter: ProductStatusFilter.fromValue(product.status),
          tags: [],
          description: product.description ?? '',
          imageUrl: product.image,
        ));

  Future<void> init() async {
    final result = await _productRepository.getCategories();
    result.foldResult(
      onError: (e) => navigator.showErrorDialog(message: e.message),
      onSuccess: (categories) => emit(state.copyWith(categories: categories)),
    );
  }

  void onNameChanged(String value) => emit(state.copyWith(name: value));
  void onCodeChanged(String value) => emit(state.copyWith(code: value, existingCodes: {}));
  void onPriceChanged(String value) => emit(state.copyWith(price: value));
  void onStockChanged(String value) => emit(state.copyWith(stock: value));
  void onCategoryChanged(CategoryEntity? value) =>
      emit(state.copyWith(category: value));
  void onStatusChanged(ProductStatusFilter value) =>
      emit(state.copyWith(statusFilter: value));
  
  void onTagsChanged(String value) {
    final tags = value
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    emit(state.copyWith(tags: tags));
  }

  void onDescriptionChanged(String value) =>
      emit(state.copyWith(description: value));
  void onImageChanged(File? file) =>
      emit(state.copyWith(imageFile: file, imageUrl: null));
  void removeImage() => emit(state.copyWith(clearImage: true, imageUrl: null));

  Future<void> update() async {
    emit(state.copyWith(status: LoadStatus.loading, isFirstSubmit: true));

    String? finalImageUrl = state.imageUrl;
    if (state.imageFile != null) {
      finalImageUrl = await CloudinaryService.uploadImage(state.imageFile!);
      if (finalImageUrl == null) {
        emit(state.copyWith(status: LoadStatus.failure));
        navigator.showErrorDialog(message: S.current.failedToUploadImage);
        return;
      }
    }

    final result = await _productRepository.updateProduct(
      id: state.product.id,
      name: state.name,
      code: state.code,
      price: double.tryParse(state.price) ?? 0.0,
      stock: int.tryParse(state.stock) ?? 0,
      categoryId: state.category?.id,
      status: state.statusFilter.value,
      tags: state.tags,
      description: state.description,
      image: finalImageUrl,
    );

    result.foldResult(
      onError: (e) {
        if (e.errorKey == AppErrorKey.productAlreadyExists) {
          final updatedCodes = Set<String>.from(state.existingCodes)
            ..add(state.code);
          emit(state.copyWith(
            status: LoadStatus.failure,
            error: e.message,
            existingCodes: updatedCodes,
          ));
        } else {
          emit(state.copyWith(status: LoadStatus.failure));
        }
        navigator.showErrorDialog(message: e.message);
      },
      onSuccess: (_) {
        emit(state.copyWith(status: LoadStatus.success));
        navigator.showSuccessSnackBar(message: S.current.productUpdateSuccess);
        navigator.pop(true);
      }
    );
  }
}
