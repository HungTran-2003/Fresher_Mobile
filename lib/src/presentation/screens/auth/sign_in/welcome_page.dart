import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/domain/repositories/auth_repository.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:finance/src/presentation/global/user/user_cubit.dart';
import 'package:finance/src/presentation/screens/auth/sign_in/widget/welcome_form.dart';
import 'package:finance/src/presentation/screens/auth/sign_in/widget/welcome_header.dart';
import 'package:finance/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'welcome_cubit.dart';
import 'welcome_navigator.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeCubit>(
      create: (context) {
        final navigator = WelcomeNavigator(context);
        return WelcomeCubit(
          authCubit: context.read<AuthCubit>(),
          authRepository: context.read<AuthRepository>(),
          userCubit: context.read<UserCubit>(),
          navigator: navigator,
        );
      },
      child: const _WelcomePageContent(),
    );
  }
}

class _WelcomePageContent extends StatelessWidget {
  const _WelcomePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryContainer,
      body: SafeArea(bottom: false, child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = context.colors;
    return BlocListener<WelcomeCubit, WelcomeState>(
      listenWhen: (prev, current) => prev.status != current.status,
      listener: (context, state) {
        if (state.status.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
      },
      child: Column(
        children: [
          // Top Header Component
          WelcomeHeader(height: size.height * 0.22),

          // Bottom Curved Content Card
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.onPrimaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(60),
                ),
              ),
              child: const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 36.0),
                child: WelcomeForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
