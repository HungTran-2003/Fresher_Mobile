import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateAccountHeader extends StatelessWidget {
  final double height;

  const CreateAccountHeader({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;
    final colors = context.colors;

    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          context.s.createAccount,
          style: textTheme.headlineLarge.copyWith(
            color: colors.onPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2),
      ),
    );
  }
}
