import 'package:crud_app/src/core/assets/app_vectors.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/widgets/images/app_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();

    return Scaffold(
      backgroundColor: context.colors.primaryLight,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSvgImage(
              AppVectors.logoApp
            )
          ],
        ),
      ),
    );
  }
}
