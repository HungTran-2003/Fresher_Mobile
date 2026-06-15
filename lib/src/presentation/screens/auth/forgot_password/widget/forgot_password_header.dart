import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../forgot_password_cubit.dart';
import '../forgot_password_state.dart';

class ForgotPasswordHeader extends StatelessWidget {
  final double height;

  const ForgotPasswordHeader({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;
    final colors = context.colors;
    final cubit = context.read<ForgotPasswordCubit>();

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back button on the left
          Positioned(
            left: 16,
            child: IconButton(
              icon: Icon(
                LucideIcons.arrowLeft,
                color: colors.onPrimary,
                size: 28,
              ),
              onPressed: cubit.handleBackPress,
            ).animate().fadeIn(duration: 400.ms),
          ),
          
          // Centered Title
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            buildWhen: (previous, current) => previous.step != current.step,
            builder: (context, state) {
              return Text(
                _getTitle(context, state.step),
                style: textTheme.headlineLarge.copyWith(
                  color: colors.onPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ).animate(key: ValueKey(state.step)).fadeIn(duration: 400.ms).slideY(begin: -0.1);
            },
          ),
        ],
      ),
    );
  }

  String _getTitle(BuildContext context, ForgotPasswordStep step) {
    switch (step) {
      case ForgotPasswordStep.email:
        return context.s.forgotPassword.replaceAll('?', '');
      case ForgotPasswordStep.pin:
        return context.s.securityPin;
      case ForgotPasswordStep.newPassword:
        return context.s.newPasswordTitle;
    }
  }
}
