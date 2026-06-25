import 'package:crud_app/src/core/utils/date_utils.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/repositories/upload_repository.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_navigator.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/widgets/product_form.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/widgets/product_image_picker.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_detail_cubit.dart';

class ProductDetailArgument {
  final ProductEntity product;

  const ProductDetailArgument({required this.product});
}

class ProductDetailPage extends StatelessWidget {
  final ProductDetailArgument argument;

  const ProductDetailPage({super.key, required this.argument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailCubit>(
      create: (context) {
        final cubit = ProductDetailCubit(
          productRepository: context.read<ProductRepository>(),
          uploadRepository: context.read<UploadRepository>(),
          product: argument.product,
          navigator: AddProductNavigator(context),
        );
        return cubit..init();
      },
      child: const ProductDetailChildPage(),
    );
  }
}

class ProductDetailChildPage extends StatefulWidget {
  const ProductDetailChildPage({super.key});

  @override
  State<ProductDetailChildPage> createState() => _ProductDetailChildPageState();
}

class _ProductDetailChildPageState extends State<ProductDetailChildPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  late final TextEditingController _tagsController;
  late final TextEditingController _descriptionController;

  late final ProductDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProductDetailCubit>();
    final product = _cubit.state.product;

    _nameController = TextEditingController(text: product.name);
    _codeController = TextEditingController(text: product.code);
    _priceController = TextEditingController(text: product.price.toString());
    _stockController = TextEditingController(text: product.stock.toString());
    // Note: Assuming tags might exist in state later, for now empty or from model if available
    _tagsController = TextEditingController(text: _cubit.state.tags.join(', '));
    _descriptionController = TextEditingController(text: product.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _tagsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.s.productManagement),
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        body: BlocListener<ProductDetailCubit, ProductDetailState>(
          listenWhen: (prev, current) =>
              prev.status != current.status ||
              prev.existingCodes != current.existingCodes,
          listener: (context, state) {
            if (state.status.isLoading) {
              AppLoadingOverlay.show(context);
            } else {
              AppLoadingOverlay.hide();
              if (state.existingCodes.isNotEmpty) {
                _formKey.currentState?.validate();
              }
            }
          },
          child: _buildBodyPage(context),
        ),
      ),
    );
  }

  Widget _buildBodyPage(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        final cubit = context.read<ProductDetailCubit>();
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProductForm(
                formKey: _formKey,
                nameController: _nameController,
                codeController: _codeController,
                priceController: _priceController,
                stockController: _stockController,
                tagsController: _tagsController,
                descriptionController: _descriptionController,
                selectedCategory: state.category,
                categories: state.categories,
                statusFilter: state.statusFilter,
                isFirstSubmit: state.isFirstSubmit,
                existingCodes: state.existingCodes,
                serverError: null,
                onNameChanged: cubit.onNameChanged,
                onCodeChanged: cubit.onCodeChanged,
                onPriceChanged: cubit.onPriceChanged,
                onStockChanged: cubit.onStockChanged,
                onCategoryChanged: cubit.onCategoryChanged,
                onTagsChanged: cubit.onTagsChanged,
                onStatusChanged: cubit.onStatusChanged,
                onDescriptionChanged: cubit.onDescriptionChanged,
                imagePicker: ProductImagePicker(
                  imageFile: state.imageFile,
                  imageUrl: state.imageUrl,
                  onImageChanged: cubit.onImageChanged,
                  onRemoveImage: cubit.removeImage,
                ),
              ),
              const SizedBox(height: 8),
              _buildUpdateTime(context),
              const SizedBox(height: 24),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(context.s.cancelButtonLabel),
                    ),
                  ),
                  Expanded(
                    child: AppFilledButton(
                      title: context.s.saveButton,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.update();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUpdateTime(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textThemes;

    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 24,
              color: colors.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 4),
            Text(
              '${context.s.createdAtLabel}: ${DateTimeUtils.formatString(_cubit.state.product.createdAt)}',
              style: textTheme.body16Semi,
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Icon(
              Icons.update,
              size: 24,
              color: colors.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 4),
            Text(
              '${context.s.updatedAtLabel}: ${DateTimeUtils.formatString(_cubit.state.product.updatedAt)}',
              style: textTheme.body16Semi,
            ),
          ],
        ),
      ],
    );
  }
}
