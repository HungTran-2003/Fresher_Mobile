import 'package:finance/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  final Color? valueColor;
  final Color? backgroundColor;
  final double? size;
  final double strokeWidth;
  final double? value;

  const AppCircularProgressIndicator({
    super.key,
    this.color,
    this.valueColor,
    this.backgroundColor,
    this.size,
    this.strokeWidth = 2,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: size ?? 24,
        height: size ?? 24,
        child: CircularProgressIndicator(
          color: color ?? AppTheme.of(context).appColorScheme.primary,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            valueColor ?? AppTheme.of(context).appColorScheme.primary,
          ),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
