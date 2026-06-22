import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/data/services/cloudinary/cloudinary_service.dart';
import 'package:crud_app/src/domain/models/entities/product_entity.dart';
import 'package:crud_app/src/presentation/widgets/images/app_cache_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isActive = product.status == 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      shadowColor: colors.outline.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: colors.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cloudinary optimized thumbnail image
            AppCacheImage(
              url: CloudinaryService.getOptimizedUrl(product.image, width: 90, height: 90),
              width: 90,
              height: 90,
              borderRadius: BorderRadius.circular(12.0),
            ),
            const SizedBox(width: 16.0),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.textThemes.body16Semi.copyWith(fontWeight: FontWeight.bold, color: colors.onSurface),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text('${context.s.sku}: ${product.code}', style: context.textThemes.des12Re.copyWith(color: colors.onSurface.withValues(alpha: 0.6))),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: context.textThemes.body16Semi.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        context.s.stockCount(product.stock),
                        style: context.textThemes.des12Re.copyWith(color: colors.onSurface.withValues(alpha: 0.8)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Category Tag
                      if (product.category != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: colors.primaryLight.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            product.category!.name,
                            style: context.textThemes.bodyTiny.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      // Status Tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
