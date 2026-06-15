import 'package:crud_app/src/core/theme/app_theme.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_circular_process_indicator.dart';
import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  // Attributes
  final String title;
  final TextStyle? titleStyle;
  final Widget? child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;
  final Color? disabledContainerColor;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;

  // Status
  final bool isEnabled;
  final bool isLoading;

  // Action
  final VoidCallback? onPressed;

  const AppFilledButton({
    super.key,
    this.title = '',
    this.titleStyle,
    this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.disabledContainerColor,
    this.isLoading = false,
    this.onPressed,
    this.isEnabled = true,
    this.padding,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? AppTheme.of(context).appColorScheme.primary;
    final disabledColor =
        disabledContainerColor ?? color.withValues(alpha: 0.38);
    return Container(
      decoration: BoxDecoration(
        color: isEnabled ? color : disabledColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 100)),
        boxShadow: boxShadow,
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 100)),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 100),
            ),
            child: _buildInk(context),
          ),
        ),
      ),
    );
  }

  Widget _buildInk(BuildContext context) {
    return Ink(
      padding: padding,
      height: height ?? 48,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 100)),
      ),
      child: _buildChildWidget(context),
    );
  }

  Widget _buildChildWidget(BuildContext context) {
    final titleStyle =
        this.titleStyle ?? AppTheme.of(context).appTextTheme.bodyLarge;
    if (isLoading) {
      return AppCircularProgressIndicator(color: titleStyle.color);
    } else {
      if (child != null) {
        return Center(child: child);
      }
      return Center(child: Text(title, style: titleStyle));
    }
  }
}
