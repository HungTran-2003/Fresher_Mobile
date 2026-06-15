import 'package:cached_network_image/cached_network_image.dart';
import 'package:finance/src/core/theme/app_theme.dart';
import 'package:finance/src/presentation/widgets/feedback/app_circular_process_indicator.dart';
import 'package:flutter/material.dart';

class AppCacheImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;
  final BoxShape shape;
  final Color? backgroundColor;

  const AppCacheImage({
    super.key,
    this.url = '',
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.shape = BoxShape.rectangle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isValidUrl = Uri.tryParse(url)?.isAbsolute == true;
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius,
        shape: shape,
      ),
      child: isValidUrl
          ? CachedNetworkImage(
              imageUrl: url,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: AppCircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AppTheme.of(context).appColorScheme.primary,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Image.network(
                  url,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceHolderImage(),
                  fit: fit,
                );
              },
              fit: fit,
            )
          : _buildPlaceHolderImage(),
    );
  }

  Widget _buildPlaceHolderImage() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.white,
      ),
    );
  }
}
