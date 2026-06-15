import 'package:crud_app/src/core/theme/app_theme.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_circular_process_indicator.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  // Attributes
  final String title;
  final TextStyle? titleStyle;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? loadingIndicatorColor;
  final EdgeInsets? padding;
  final double? borderRadius;

  // Status
  final bool isEnabled;
  final bool isLoading;

  // Action & callback
  final VoidCallback? onPressed;

  const AppOutlinedButton({
    super.key,
    this.title = '',
    this.titleStyle,
    this.child,
    this.width,
    this.height,
    this.borderColor,
    this.loadingIndicatorColor,
    this.isLoading = false,
    this.onPressed,
    this.isEnabled = true,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        this.borderColor ?? AppTheme.of(context).appColorScheme.primary;
    return Material(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        child: Container(
          height: height ?? 48,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            border: Border.all(
              color: isEnabled
                  ? borderColor
                  : borderColor.withValues(alpha: 0.38),
              width: 1,
            ),
          ),
          child: _buildChildWidget(context),
        ),
      ),
    );
  }

  Widget _buildChildWidget(BuildContext context) {
    final titleStyle =
        this.titleStyle ?? AppTheme.of(context).appTextTheme.bodyLarge;
    if (isLoading) {
      return AppCircularProgressIndicator(
        color:
            loadingIndicatorColor ??
            borderColor ??
            AppTheme.of(context).appColorScheme.primary,
      );
    } else {
      if (child != null) {
        return Center(child: child);
      }
      return Center(
        child: Text(
          title,
          style: isEnabled
              ? titleStyle.copyWith(height: 1.0)
              : titleStyle.copyWith(
                  color: titleStyle.color?.withValues(alpha: 0.38),
                  height: 1.0,
                ),
        ),
      );
    }
  }
}
