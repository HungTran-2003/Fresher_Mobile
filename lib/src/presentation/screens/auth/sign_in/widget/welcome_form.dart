import 'package:finance/src/core/theme/app_theme.dart';
import 'package:finance/src/core/utils/app_validators.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/widgets/inputs/buttons/app_button_wrapper.dart';
import 'package:finance/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:finance/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../welcome_cubit.dart';
import 'fingerprint_button.dart';
import 'social_login_buttons.dart';

class WelcomeForm extends StatefulWidget {
  const WelcomeForm({super.key});

  @override
  State<WelcomeForm> createState() => _WelcomeFormState();
}

class _WelcomeFormState extends State<WelcomeForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<WelcomeCubit>().logIn(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textThemes;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputTextField(context, textTheme),
          const SizedBox(height: 28),
          _buildButtons(context),
          const SizedBox(height: 24),
          _buildAnotherMethodLogin(context),
        ],
      ),
    );
  }

  Widget _buildInputTextField(BuildContext context, AppTextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        AppTextField(
          controller: _usernameController,
          labelText: context.s.usernameOrEmail,
          hintText: context.s.emailHint,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => AppValidators.validateRequired(
            context,
            value,
            context.s.enterUsernameOrEmailError,
          ),
        ).animate().fadeIn(delay: 150.ms, duration: 400.ms),

        AppTextField(
          controller: _passwordController,
          labelText: context.s.password,
          isSecure: true,
          hintText: context.s.passwordHint,
          maxLines: 1,
          validator: (value) => AppValidators.validateRequired(
            context,
            value,
            context.s.enterPasswordError,
          ),
        ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        spacing: 16,
        children: [
          AppFilledButton(
            title: context.s.logIn,
            titleStyle: context.textThemes.titleLarge.copyWith(
              color: context.colors.textField,
            ),
            color: context.colors.primary,
            borderRadius: 30,
            height: 45,
            width: 200,
            onPressed: _onLogin,
          ),

          AppButtonWrapper(
            onPressed: () {
              context.read<WelcomeCubit>().navigator.toForgotPassword();
            },
            child: Text(
              context.s.forgotPassword,
              style: context.textThemes.titleSmall,
            ),
          ),

          AppFilledButton(
            title: context.s.signUp,
            titleStyle: context.textThemes.titleLarge.copyWith(
              color: context.colors.textField,
            ),
            color: context.colors.onPrimary,
            borderRadius: 30,
            height: 45,
            width: 200,
            onPressed: () {
              context.read<WelcomeCubit>().navigator.toCreateAccount();
            },
          ),
        ],
      ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
    );
  }

  Widget _buildAnotherMethodLogin(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        spacing: 16,
        children: [
          FingerprintButton(cubit: context.read<WelcomeCubit>()),
          SocialLoginButtons(
            onGoogleTap: () {
              context.read<WelcomeCubit>().logInWithGoogle();
            },
          ),
        ],
      ),
    );
  }
}
