import 'package:finance/src/core/theme/app_theme.dart';
import 'package:finance/src/core/utils/app_validators.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/widgets/inputs/text_field/app_date_field.dart';
import 'package:finance/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:finance/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../create_account_cubit.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onSignUp() async {
    if (_formKey.currentState!.validate()) {
      context.read<CreateAccountCubit>().signUp(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        mobileNumber: _mobileController.text.trim(),
        dob: _dobController.text.trim(),
        password: _passwordController.text.trim(),
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
          _buildInputFields(context, textTheme),
          const SizedBox(height: 24),
          _buildTermsAndPrivacy(context),
          const SizedBox(height: 24),
          _buildButtons(context),
          const SizedBox(height: 24),
          _buildLoginLink(context),
        ],
      ),
    );
  }

  Widget _buildInputFields(BuildContext context, AppTextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        AppTextField(
          controller: _fullNameController,
          labelText: context.s.fullName,
          hintText: context.s.fullNameHint,
          validator: (value) => AppValidators.validateFullName(context, value),
        ).animate().fadeIn(delay: 150.ms, duration: 400.ms),

        AppTextField(
          controller: _emailController,
          labelText: context.s.email,
          hintText: context.s.emailHint,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => AppValidators.validateEmail(context, value),
        ).animate().fadeIn(delay: 250.ms, duration: 400.ms),

        AppTextField(
          controller: _mobileController,
          labelText: context.s.mobileNumber,
          hintText: context.s.phoneHint,
          keyboardType: TextInputType.phone,
        ).animate().fadeIn(delay: 350.ms, duration: 400.ms),

        AppDateField(
          controller: _dobController,
          labelText: context.s.dateOfBirth,
          hintText: context.s.dateHint,
        ).animate().fadeIn(delay: 450.ms, duration: 400.ms),

        AppTextField(
          controller: _passwordController,
          labelText: context.s.password,
          hintText: context.s.passwordHint,
          isSecure: true,
          validator: (value) => AppValidators.validatePassword(context, value),
        ).animate().fadeIn(delay: 550.ms, duration: 400.ms),

        AppTextField(
          controller: _confirmPasswordController,
          labelText: context.s.confirmPassword,
          hintText: context.s.passwordHint,
          isSecure: true,
          validator: (value) => AppValidators.validateConfirmPassword(
            context,
            value,
            _passwordController.text,
          ),
        ).animate().fadeIn(delay: 650.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildTermsAndPrivacy(BuildContext context) {
    final textTheme = context.textThemes;
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: context.s.byContinuingAgree,
            style: textTheme.bodySmall.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: context.s.termsOfUse,
                style: textTheme.bodySmall.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: context.s.andWord),
              TextSpan(
                text: context.s.privacyPolicy,
                style: textTheme.bodySmall.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 750.ms, duration: 400.ms);
  }

  Widget _buildButtons(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        spacing: 16,
        children: [
          AppFilledButton(
            title: context.s.signUp,
            titleStyle: context.textThemes.titleLarge.copyWith(
              color: context.colors.textField,
            ),
            color: context.colors.primary,
            borderRadius: 30,
            height: 45,
            width: 200,
            onPressed: _onSignUp,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 850.ms, duration: 400.ms);
  }

  Widget _buildLoginLink(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          context.read<CreateAccountCubit>().navigator.backToLogin();
        },
        child: RichText(
          text: TextSpan(
            text: context.s.alreadyHaveAccount,
            style: context.textThemes.bodySmall.copyWith(
              color: context.colors.onSurface.withValues(alpha: 0.6),
            ),
            children: [
              TextSpan(
                text: context.s.logIn,
                style: context.textThemes.bodySmall.copyWith(
                  color: context.colors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 950.ms, duration: 400.ms);
  }
}
