import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double thickness;
  final double? length;
  final Color? color;
  final bool isVertical;
  final BorderRadius? borderRadius;

  const AppDivider({
    super.key,
    this.thickness = 1.0,
    this.length,
    this.color,
    this.isVertical = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isVertical ? thickness : (length ?? double.infinity),
      height: isVertical ? (length ?? double.infinity) : thickness,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).dividerColor,
        borderRadius: borderRadius,
      ),
    );
  }
}
