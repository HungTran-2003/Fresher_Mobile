import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppSvgImage extends StatelessWidget {
  final String name;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ColorFilter? colorFilter;
  final ColorMapper? colorMapper;
  final String? package;

  const AppSvgImage(
    this.name, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.colorFilter,
    this.colorMapper,
    this.package,
  });

  String _resolveAssetPath() {
    if (package != null) {
      return 'packages/$package/$name';
    }
    return name;
  }

  Future<Widget> _loadSvgString() async {
    final svgString = await rootBundle.loadString(_resolveAssetPath());
    return SvgPicture.string(
      svgString,
      width: width,
      height: height,
      fit: fit,
      colorMapper: colorMapper,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (colorMapper == null) {
      return SvgPicture.asset(
        name,
        width: width,
        height: height,
        fit: fit,
        colorFilter: colorFilter,
        package: package,
      );
    }
    return FutureBuilder<Widget>(
      future: _loadSvgString(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        return snapshot.data!;
      },
    );
  }
}
