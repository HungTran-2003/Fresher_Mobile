import 'package:finance/src/core/utils/app_validators.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/screens/auth/sign_in/widget/social_login_buttons.dart';
import 'package:finance/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:finance/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../forgot_password_cubit.dart';
import '../forgot_password_state.dart';

class ForgotPasswordEmailForm extends StatefulWidget {
  const ForgotPasswordEmailForm({super.key});

  @override
  State<ForgotPasswordEmailForm> createState() =>
      _ForgotPasswordEmailFormState();
}

class _ForgotPasswordEmailFormState extends State<ForgotPasswordEmailForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ForgotPasswordCubit>();
    _emailController = TextEditingController(text: cubit.state.email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<ForgotPasswordCubit>();
      cubit.updateEmail(_emailController.text.trim());
      cubit.sendVerificationCode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;
    final colors = context.colors;
    final cubit = context.read<ForgotPasswordCubit>();

    return Form(
      key: _formKey,
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        buildWhen: (prev, current) => prev.status != current.status,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title "Reset Password?"
              Text(
                context.s.resetPassword,
                style: textTheme.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ).animate().fadeIn(delay: 50.ms, duration: 400.ms),
              const SizedBox(height: 12),

              // Description
              Text(
                context.s.resetPasswordDescription,
                style: textTheme.bodyMedium.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                  height: 1.4,
                ),
              ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
              const SizedBox(height: 32),

              // Label "Enter Email Address"
              Text(
                context.s.enterEmailAddress,
                style: textTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
              ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
              const SizedBox(height: 8),

              // Email input
              AppTextField(
                controller: _emailController,
                hintText: context.s.emailHint,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    AppValidators.validateEmail(context, value),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
              const SizedBox(height: 28),

              // Next Step button
              SizedBox(
                width: double.infinity,
                child: AppFilledButton(
                  title: context.s.nextStep,
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
              ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
              const SizedBox(height: 16),

              // Sign Up button
              SizedBox(
                width: double.infinity,
                child: AppFilledButton(
                  title: context.s.signUp,
                  titleStyle: textTheme.titleMedium.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  color: colors.onPrimaryContainer,
                  borderRadius: 30,
                  height: 56,
                  onPressed: () => cubit.navigator.toCreateAccount(),
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
              const SizedBox(height: 28),

              // Social login buttons
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
      ),
    );
  }
}
