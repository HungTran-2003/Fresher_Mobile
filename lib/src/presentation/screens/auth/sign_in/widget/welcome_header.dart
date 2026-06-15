import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeHeader extends StatelessWidget {
  final double height;

  const WelcomeHeader({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;

    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          context.s.welcome,
          style: textTheme.headlineMedium,
        ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2),
      ),
    );
  }
}
