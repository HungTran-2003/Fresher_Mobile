import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_cubit.dart';
import 'forgot_password_navigator.dart';
import 'forgot_password_state.dart';
import 'widget/forgot_password_email_form.dart';
import 'widget/forgot_password_header.dart';
import 'widget/forgot_password_new_password_form.dart';
import 'widget/forgot_password_pin_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (context) {
        final navigator = ForgotPasswordNavigator(context);
        return ForgotPasswordCubit(
          authRepository: context.read<AuthRepository>(),
          navigator: navigator,
        );
      },
      child: const _ForgotPasswordPageContent(),
    );
  }
}

class _ForgotPasswordPageContent extends StatefulWidget {
  const _ForgotPasswordPageContent();

  @override
  State<_ForgotPasswordPageContent> createState() => _ForgotPasswordPageContentState();
}

class _ForgotPasswordPageContentState extends State<_ForgotPasswordPageContent> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Dynamic Header Component
            ForgotPasswordHeader(height: size.height * 0.16),

            // Bottom Curved Content Card
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(60),
                  ),
                ),
                child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                  listenWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.successMessage != current.successMessage,
                  listener: (context, state) {
                    if (state.status == ForgotPasswordStatus.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.s.passwordChangedSuccess),
                          backgroundColor: colors.successText,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                    if (state.successMessage == 'resendPinSuccess') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.s.resendPinSuccess),
                          backgroundColor: colors.successText,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    buildWhen: (previous, current) =>
                        previous.step != current.step,
                    builder: (context, state) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28.0,
                          vertical: 36.0,
                        ),
                        child: _buildForm(state.step),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(ForgotPasswordStep step) {
    switch (step) {
      case ForgotPasswordStep.email:
        return const ForgotPasswordEmailForm();
      case ForgotPasswordStep.pin:
        return const ForgotPasswordPinForm();
      case ForgotPasswordStep.newPassword:
        return const ForgotPasswordNewPasswordForm();
    }
  }
}
