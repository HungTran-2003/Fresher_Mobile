import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/repositories/upload_repository.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_product_cubit.dart';
import 'add_product_navigator.dart';
import 'widgets/product_form.dart';
import 'widgets/product_image_picker.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProductCubit>(
      create: (context) {
        final cubit = AddProductCubit(
          productRepository: context.read<ProductRepository>(),
          uploadRepository: context.read<UploadRepository>(),
          navigator: AddProductNavigator(context),
        );
        return cubit..init();
      },
      child: const AddProductChildPage(),
    );
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

  late final AddProductCubit _cubit;
  late final AddProductNavigator _navigator;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AddProductCubit>();
    _navigator = AddProductNavigator(context);

    _nameController = TextEditingController();
    _codeController = TextEditingController();
    _priceController = TextEditingController();
    _stockController = TextEditingController();
    _tagsController = TextEditingController();
    _descriptionController = TextEditingController();
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
          title: Text(
            context.s.addNewProduct,
            style: context.textThemes.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        body: BlocListener<AddProductCubit, AddProductState>(
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
          child: BlocBuilder<AddProductCubit, AddProductState>(
            builder: (context, state) {
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
                      serverError: state.error,
                      onNameChanged: _cubit.onNameChanged,
                      onCodeChanged: _cubit.onCodeChanged,
                      onPriceChanged: _cubit.onPriceChanged,
                      onStockChanged: _cubit.onStockChanged,
                      onCategoryChanged: _cubit.onCategoryChanged,
                      onTagsChanged: _cubit.onTagsChanged,
                      onStatusChanged: _cubit.onStatusChanged,
                      onDescriptionChanged: _cubit.onDescriptionChanged,
                      imagePicker: ProductImagePicker(
                        imageFile: state.imageFile,
                        onImageChanged: _cubit.onImageChanged,
                        onRemoveImage: _cubit.removeImage,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _navigator.back(),
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
                                _cubit.submit();
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
          ),
        ),
      ),
    );
  }
}
