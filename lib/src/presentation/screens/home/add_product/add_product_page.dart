import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_product_controller.dart';
import 'widgets/product_form.dart';
import 'widgets/product_image_picker.dart';

class AddProductPage extends GetView<AddProductController> {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddProductChildPage();
  }
}

class AddProductChildPage extends StatefulWidget {
  const AddProductChildPage({super.key});

  @override
  State<AddProductChildPage> createState() => _AddProductChildPageState();
}

class _AddProductChildPageState extends State<AddProductChildPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  late final TextEditingController _tagsController;
  late final TextEditingController _descriptionController;

  late final AddProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<AddProductController>();

    _nameController = TextEditingController();
    _codeController = TextEditingController();
    _priceController = TextEditingController();
    _stockController = TextEditingController();
    _tagsController = TextEditingController();
    _descriptionController = TextEditingController();
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

  void _triggerValidator() {
    ever(_controller.state.existingCodes, (existingCodes) {
      if (existingCodes.isNotEmpty) {
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
        title: Text(
          context.s.addNewProduct,
          style: context.textThemes.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Obx(() {
                return ProductForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  codeController: _codeController,
                  priceController: _priceController,
                  stockController: _stockController,
                  tagsController: _tagsController,
                  descriptionController: _descriptionController,
                  selectedCategory: _controller.state.category.value,
                  categories: _controller.state.categories.toList(),
                  statusFilter: _controller.state.statusFilter.value,
                  isFirstSubmit: _controller.state.isFirstSubmit.value,
                  existingCodes: _controller.state.existingCodes,
                  serverError: _controller.state.error.value,
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
                    onImageChanged: _controller.onImageChanged,
                    onRemoveImage: _controller.removeImage,
                  ),
                );
              }),
              const SizedBox(height: 24),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
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
                _controller.submit();
              }
            },
          ),
        ),
      ],
    );
  }
}
