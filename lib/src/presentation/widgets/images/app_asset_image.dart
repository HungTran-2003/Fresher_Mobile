import 'package:flutter/material.dart';

class AppAssetImage extends StatelessWidget {
  final String name;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppAssetImage(
    this.name, {
    super.key,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(name, width: width, height: height, fit: fit);
  }
}
