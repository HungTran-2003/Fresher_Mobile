import 'package:flutter/material.dart';

class AppButtonWrapper extends StatelessWidget {
  // Attributes
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;

  final EdgeInsets? padding;

  // Action
  final VoidCallback? onPressed;

  const AppButtonWrapper({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          onTap: onPressed,
          child: Container(
            width: width,
            height: height,
            padding: padding,
            child: Center(widthFactor: 1.0, heightFactor: 1.0, child: child),
          ),
        ),
      ),
    );
  }
}
