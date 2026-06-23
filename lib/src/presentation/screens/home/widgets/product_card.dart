import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/data/services/cloudinary/cloudinary_service.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/presentation/widgets/images/app_cache_image.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_button_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onProductTap;
  final VoidCallback onDeleteTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onProductTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Slidable(
      key: ValueKey(product.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDeleteTap(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: context.s.deleteButton,
          ),
        ],
      ),
      child: AppButtonWrapper(
        onPressed: onProductTap,
        child: Card(
          elevation: 2,
          shadowColor: colors.outline.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: colors.surfaceContainer,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                _buildProductImage(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNameAndSku(context),
                      const SizedBox(height: 4.0),
                      _buildPriceAndStock(context),
                      const SizedBox(height: 8.0),
                      _buildTags(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return AppCacheImage(
      url: CloudinaryService.getOptimizedUrl(
        product.image,
        width: 90,
        height: 90,
      ),
      width: 90,
      height: 90,
      borderRadius: BorderRadius.circular(12.0),
    );
  }

  Widget _buildNameAndSku(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: context.textThemes.body16Semi.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4.0),
        Text(
          '${context.s.sku}: ${product.code}',
          style: context.textThemes.des12Re.copyWith(
            color: context.colors.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndStock(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: context.textThemes.body16Semi.copyWith(
            color: context.colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          context.s.stockCount(product.stock),
          style: context.textThemes.des12Re.copyWith(
            color: context.colors.onSurface.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildTags(BuildContext context) {
    final colors = context.colors;
    final isActive = product.status == 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Category Tag
        if (product.category != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: colors.primaryLight.withValues(
                alpha: 0.15,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              product.category!.name,
              style: context.textThemes.bodyTiny.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          const SizedBox.shrink(),
        // Status Tag
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: isActive ? colors.successContainer : colors.errorContainer,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            isActive ? context.s.active : context.s.inactive,
            style: context.textThemes.bodyTiny.copyWith(
              color: isActive ? colors.successText : colors.errorText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
