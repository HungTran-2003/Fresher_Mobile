import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/screens/auth/sign_in/widget/biometric_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../welcome_cubit.dart';

class FingerprintButton extends StatelessWidget {
  final WelcomeCubit cubit;

  const FingerprintButton({super.key, required this.cubit});

  Future<void> _onBiometric(BuildContext context) async {
    final success = await BiometricBottomSheet.show(context);
    if (success == true) {
      cubit.biometricLogIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;
    final colors = context.colors;

    return Center(
      child: InkWell(
        onTap: () => _onBiometric(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: 'Use ',
              style: textTheme.bodyMedium.copyWith(
                color: colors.onSurface.withValues(alpha: 0.7),
              ),
              children: [
                TextSpan(
                  text: 'Fingerprint',
                  style: textTheme.bodyMedium.copyWith(
                    color: colors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ' To Access'),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 450.ms, duration: 400.ms);
  }
}
