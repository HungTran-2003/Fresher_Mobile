import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'login_cubit.dart';
import 'login_navigator.dart';
import 'widget/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) {
        final navigator = LoginNavigator(context);
        return LoginCubit(
          authCubit: context.read<AuthCubit>(),
          userCubit: context.read<UserCubit>(),
          authRepository: context.read<AuthRepository>(),
          navigator: navigator,
        );
      },
      child: const _LoginPageContent(),
    );
  }
}

class _LoginPageContent extends StatelessWidget {
  const _LoginPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: BlocListener<LoginCubit, LoginState>(
          listenWhen: (prev, current) => prev.status != current.status,
          listener: (context, state) {
            if (state.status.isLoading) {
              AppLoadingOverlay.show(context);
            } else {
              AppLoadingOverlay.hide();
            }
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: const SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              physics: BouncingScrollPhysics(),
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
