import 'package:finance/src/core/utils/app_validators.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:finance/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../forgot_password_cubit.dart';
import '../forgot_password_state.dart';

class ForgotPasswordNewPasswordForm extends StatefulWidget {
  const ForgotPasswordNewPasswordForm({super.key});

  @override
  State<ForgotPasswordNewPasswordForm> createState() => _ForgotPasswordNewPasswordFormState();
}

class _ForgotPasswordNewPasswordFormState extends State<ForgotPasswordNewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<ForgotPasswordCubit>();
      cubit.updateNewPassword(_passwordController.text);
      cubit.updateConfirmPassword(_confirmPasswordController.text);
      cubit.resetPassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;
    final colors = context.colors;

    return Form(
      key: _formKey,
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        buildWhen: (prev, current) =>
            prev.status != current.status ||
            prev.obscurePassword != current.obscurePassword ||
            prev.obscureConfirmPassword != current.obscureConfirmPassword,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New Password Field
              Text(
                context.s.newPasswordTitle,
                style: textTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
              ).animate().fadeIn(delay: 50.ms, duration: 400.ms),
              const SizedBox(height: 8),
              AppTextField(
                controller: _passwordController,
                isSecure: true,
                hintText: context.s.passwordHint,
                validator: (value) => AppValidators.validatePassword(context, value),
              ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
              
              const SizedBox(height: 24),

              // Confirm New Password Field
              Text(
                context.s.confirmNewPassword,
                style: textTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
              ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
              const SizedBox(height: 8),
              AppTextField(
                controller: _confirmPasswordController,
                isSecure: true,
                hintText: context.s.passwordHint,
                validator: (value) => AppValidators.validateConfirmPassword(
                  context,
                  value,
                  _passwordController.text,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
              
              const SizedBox(height: 48),

              // "Change Password" Action Button
              SizedBox(
                width: double.infinity,
                child: AppFilledButton(
                  title: context.s.changePassword,
                  titleStyle: textTheme.titleMedium.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  color: colors.primary,
                  borderRadius: 30,
                  height: 56,
                  isLoading: state.status == ForgotPasswordStatus.loading,
                  onPressed: _onSubmit,
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
            ],
          );
        },
      ),
    );
  }
}
