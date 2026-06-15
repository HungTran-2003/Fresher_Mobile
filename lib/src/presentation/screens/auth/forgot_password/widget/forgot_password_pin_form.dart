import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/screens/auth/sign_in/widget/social_login_buttons.dart';
import 'package:finance/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../forgot_password_cubit.dart';
import '../forgot_password_state.dart';

class ForgotPasswordPinForm extends StatefulWidget {
  const ForgotPasswordPinForm({super.key});

  @override
  State<ForgotPasswordPinForm> createState() => _ForgotPasswordPinFormState();
}

class _ForgotPasswordPinFormState extends State<ForgotPasswordPinForm> {
  static const int _pinLength = 6;
  final List<TextEditingController> _controllers = List.generate(
    _pinLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _pinLength,
    (_) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < _pinLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    _updatePinState();
  }

  void _updatePinState() {
    final pin = _controllers.map((c) => c.text).join();
    context.read<ForgotPasswordCubit>().updatePin(pin);
  }

  void _onSubmit() {
    final pin = _controllers.map((c) => c.text).join();
    if (pin.length == _pinLength) {
      context.read<ForgotPasswordCubit>().verifyPin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;
    final colors = context.colors;
    final cubit = context.read<ForgotPasswordCubit>();

    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (prev, current) =>
          prev.status != current.status || prev.pin != current.pin,
      builder: (context, state) {
        return Column(
          children: [
            // Center heading "Enter Security Pin"
            Center(
              child: Text(
                context.s.enterSecurityPin,
                style: textTheme.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
            ).animate().fadeIn(delay: 50.ms, duration: 400.ms),
            const SizedBox(height: 36),

            // 6 Circular OTP inputs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_pinLength, (index) {
                return SizedBox(
                  width: 48,
                  height: 48,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: textTheme.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      fillColor: colors.onPrimaryContainer,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colors.primary,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colors.primary,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colors.secondary,
                          width: 2.5,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                      _onChanged(index, value);
                    },
                  ),
                );
              }),
            ).animate().fadeIn(delay: 150.ms, duration: 400.ms),

            const SizedBox(height: 48),

            // "Accept" Button
            SizedBox(
              width: double.infinity,
              child: AppFilledButton(
                title: context.s.accept,
                titleStyle: textTheme.titleMedium.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                color: colors.primary,
                borderRadius: 30,
                height: 56,
                isLoading: state.status == ForgotPasswordStatus.loading,
                onPressed: state.pin.length == _pinLength ? _onSubmit : null,
              ),
            ).animate().fadeIn(delay: 250.ms, duration: 400.ms),

            const SizedBox(height: 16),

            // "Send Again" Button
            SizedBox(
              width: double.infinity,
              child: AppFilledButton(
                title: context.s.sendAgain,
                titleStyle: textTheme.titleMedium.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                color: colors.onPrimaryContainer,
                borderRadius: 30,
                height: 56,
                onPressed: () => cubit.resendPin(),
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

            const SizedBox(height: 36),

            // Divider + Social buttons
            const SocialLoginButtons(),
            const SizedBox(height: 28),

            // Bottom link "Don't have an account? Sign Up"
            Center(
              child: InkWell(
                onTap: () => cubit.navigator.toCreateAccount(),
                child: RichText(
                  text: TextSpan(
                    text: context.s.dontHaveAccount,
                    style: textTheme.bodySmall.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                    children: [
                      TextSpan(
                        text: context.s.signUp,
                        style: textTheme.bodySmall.copyWith(
                          color: colors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
          ],
        );
      },
    );
  }
}
