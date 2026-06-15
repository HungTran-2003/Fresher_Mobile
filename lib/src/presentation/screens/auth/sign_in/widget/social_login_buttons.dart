import 'package:finance/src/core/assets/app_vectors.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/widgets/images/app_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onFacebookTap;

  const SocialLoginButtons({
    super.key,
    this.onGoogleTap,
    this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;
    final colors = context.colors;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: colors.outlineLightest,
                endIndent: 12,
              ),
            ),
            Text(
              context.s.orSignUpWith,
              style: textTheme.bodySmall.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
            Expanded(
              child: Divider(
                color: colors.outlineLightest,
                indent: 12,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            _buildSocialButton(
              colors,
              AppVectors.icFacebook,
              onFacebookTap ?? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Facebook login initiated')),
                );
              },
            ),
            _buildSocialButton(
              colors,
              AppVectors.icGoogle,
              onGoogleTap ?? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Google login initiated')),
                );
              },
            ),
          ],
        ).animate().fadeIn(delay: 550.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildSocialButton(
    dynamic colors,
    String vectorPath,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(27),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colors.outlineLightest,
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: AppSvgImage(
          vectorPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
