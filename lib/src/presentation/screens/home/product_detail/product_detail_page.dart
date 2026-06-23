import 'package:crud_app/src/core/utils/date_utils.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/widgets/product_form.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/widgets/product_image_picker.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_detail_controller.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key, dynamic argument});

  @override
  Widget build(BuildContext context) {
    return const ProductDetailChildPage();
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

  late final ProductDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<ProductDetailController>();
    final product = _controller.product;

    _nameController = TextEditingController(text: product.name);
    _codeController = TextEditingController(text: product.code);
    _priceController = TextEditingController(text: product.price.toString());
    _stockController = TextEditingController(text: product.stock.toString());
    _tagsController = TextEditingController(text: _controller.state.tags.join(', '));
    _descriptionController = TextEditingController(text: product.description);

    _triggerLoadingOverlay();
    _triggerValidator();
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

  void _triggerLoadingOverlay() {
    ever(_controller.state.status, (status) {
      if (status == LoadStatus.loading) {
        AppLoadingOverlay.show(context);
      } else {
        AppLoadingOverlay.hide();
      }
    });
  }

  void _triggerValidator(){
    ever(_controller.state.existingCodes, (existingCodes) {
      if(existingCodes.isNotEmpty){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _formKey.currentState?.validate();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.s.productManagement),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Obx(() {
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
                  selectedCategory: _controller.state.category.value,
                  categories: _controller.state.categories,
                  statusFilter: _controller.state.statusFilter.value,
                  isFirstSubmit: _controller.state.isFirstSubmit.value,
                  existingCodes: _controller.state.existingCodes,
                  serverError: null,
                  onNameChanged: _controller.onNameChanged,
                  onCodeChanged: _controller.onCodeChanged,
                  onPriceChanged: _controller.onPriceChanged,
                  onStockChanged: _controller.onStockChanged,
                  onCategoryChanged: _controller.onCategoryChanged,
                  onTagsChanged: _controller.onTagsChanged,
                  onStatusChanged: _controller.onStatusChanged,
                  onDescriptionChanged: _controller.onDescriptionChanged,
                  imagePicker: ProductImagePicker(
                    imageFile: _controller.state.imageFile.value,
                    imageUrl: _controller.state.imageUrl.value,
                    onImageChanged: _controller.onImageChanged,
                    onRemoveImage: _controller.removeImage,
                  ),
                ),
                const SizedBox(height: 8),
                _buildUpdateTime(context),
                const SizedBox(height: 24),
                _buildButton(context),
              ],
            ),
          );
        }),
      ),
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
              '${context.s.createdAtLabel}: ${DateTimeUtils.formatString(_controller.product.createdAt)}',
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
              '${context.s.updatedAtLabel}: ${DateTimeUtils.formatString(_controller.product.updatedAt)}',
              style: textTheme.body16Semi,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context){
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => _controller.navigator.pop(),
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
                _controller.updateProduct();
              }
            },
          ),
        ),
      ],
    );
  }
}
