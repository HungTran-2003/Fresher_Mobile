import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int totalDots;
  final PageController controller;
  final double dotSize;
  final double spacing;

  const OnboardingIndicator({
    super.key,
    required this.totalDots,
    required this.controller,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double currentPage = 0;
        if (controller.hasClients) {
          currentPage = controller.page ?? 0;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalDots, (index) {
            double delta = (index - currentPage).abs();
            double factor = (1 - delta).clamp(0.0, 1.0);

            // Màu sắc chuyển đổi mượt mà giữa primary và outline
            Color color = Color.lerp(
              Colors.transparent,
              context.colors.indicatorSelect,
              factor,
            )!;

            Color outlineColor = Color.lerp(
              context.colors.outlineStrong,
              Colors.transparent,
              factor,
            )!;

            return Container(
              width: dotSize,
              height: dotSize,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(dotSize / 2),
                color: color,
                border: Border.all(color: outlineColor, width: 2.0),
              ),
            );
          }),
        );
      },
    );
  }
}
