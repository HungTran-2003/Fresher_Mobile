import 'package:crud_app/src/core/utils/app_validators.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/models/enum/product_status_filter.dart';
import 'package:crud_app/src/presentation/widgets/inputs/menu/app_filter_dropdown.dart';
import 'package:crud_app/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

class ProductForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController codeController;
  final TextEditingController priceController;
  final TextEditingController stockController;
  final TextEditingController tagsController;
  final TextEditingController descriptionController;
  final CategoryEntity? selectedCategory;
  final List<CategoryEntity> categories;
  final ProductStatusFilter statusFilter;
  final bool isFirstSubmit;
  final Set<String> existingCodes;
  final String? serverError;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onCodeChanged;
  final ValueChanged<String> onPriceChanged;
  final ValueChanged<String> onStockChanged;
  final ValueChanged<CategoryEntity?> onCategoryChanged;
  final ValueChanged<String> onTagsChanged;
  final ValueChanged<ProductStatusFilter> onStatusChanged;
  final ValueChanged<String> onDescriptionChanged;
  final Widget imagePicker;

  const ProductForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.codeController,
    required this.priceController,
    required this.stockController,
    required this.tagsController,
    required this.descriptionController,
    this.selectedCategory,
    required this.categories,
    required this.statusFilter,
    required this.isFirstSubmit,
    required this.existingCodes,
    this.serverError,
    required this.onNameChanged,
    required this.onCodeChanged,
    required this.onPriceChanged,
    required this.onStockChanged,
    required this.onCategoryChanged,
    required this.onTagsChanged,
    required this.onStatusChanged,
    required this.onDescriptionChanged,
    required this.imagePicker,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: isFirstSubmit
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        spacing: 16,
        children: [
          imagePicker,
          AppTextField(
            controller: nameController,
            labelText: context.s.productNameLabel,
            hintText: context.s.productNameHint,
            onChanged: onNameChanged,
            maxLines: 1,
            validator: (val) => AppValidators.validateProductName(context, val),
          ),
          AppTextField(
            controller: codeController,
            labelText: context.s.productCodeLabel,
            hintText: context.s.productCodeHint,
            onChanged: onCodeChanged,
            maxLines: 1,
            validator: (val) {
              final basicError = AppValidators.validateProductCode(
                context,
                val,
              );
              if (basicError != null) return basicError;

              if (val != null && existingCodes.contains(val.trim())) {
                return serverError ?? "Code already exists";
              }
              return null;
            },
          ),
          // Price and Stock
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: AppTextField(
                  controller: priceController,
                  labelText: context.s.priceLabel,
                  hintText: context.s.priceHint,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onChanged: onPriceChanged,
                  validator: (val) => AppValidators.validatePrice(context, val),
                ),
              ),
              Expanded(
                child: AppTextField(
                  controller: stockController,
                  labelText: context.s.stockLabel,
                  hintText: context.s.stockHint,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onChanged: onStockChanged,
                  validator: (val) => AppValidators.validateStock(context, val),
                ),
              ),
            ],
          ),
          // Category
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.s.category, style: context.textThemes.body16Bo),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: AppFilterDropdown<int?>(
                  value: selectedCategory?.id,
                  hint: context.s.category,
                  items: categories
                      .map(
                        (e) =>
                            DropdownMenuItem(value: e.id, child: Text(e.name)),
                      )
                      .toList(),
                  onChanged: (val) {
                    final cat = categories.firstWhere((e) => e.id == val);
                    onCategoryChanged(cat);
                  },
                ),
              ),
            ],
          ),
          AppTextField(
            controller: tagsController,
            labelText: context.s.tagsLabel,
            hintText: context.s.tagsHint,
            onChanged: onTagsChanged,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.s.status, style: context.textThemes.body16Bo),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: AppFilterDropdown<ProductStatusFilter>(
                  value: statusFilter,
                  hint: context.s.status,
                  items: ProductStatusFilter.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.getLabel(context)),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) onStatusChanged(val);
                  },
                ),
              ),
            ],
          ),
          AppTextField(
            controller: descriptionController,
            labelText: context.s.descriptionLabel,
            hintText: context.s.descriptionHint,
            maxLines: 3,
            onChanged: onDescriptionChanged,
          ),
        ],
      ),
    );
  }
}
