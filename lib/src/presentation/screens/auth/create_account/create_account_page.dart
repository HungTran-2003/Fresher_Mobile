import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/domain/repositories/auth_repository.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:finance/src/presentation/screens/auth/create_account/widget/create_account_form.dart';
import 'package:finance/src/presentation/screens/auth/create_account/widget/create_account_header.dart';
import 'package:finance/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_account_cubit.dart';
import 'create_account_navigator.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateAccountCubit>(
      create: (context) {
        final navigator = CreateAccountNavigator(context);
        return CreateAccountCubit(
          authCubit: context.read<AuthCubit>(),
          authRepository: context.read<AuthRepository>(),
          navigator: navigator,
        );
      },
      child: const _CreateAccountPageContent(),
    );
  }
}

class _CreateAccountPageContent extends StatelessWidget {
  const _CreateAccountPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryContainer,
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = context.colors;
    return BlocListener<CreateAccountCubit, CreateAccountState>(
      listenWhen: (prev, current) => prev.status != current.status,
      listener: (context, state) {
        if (state.status.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide;
        }
      },
      child: Column(
        children: [
          // Top Header Component
          CreateAccountHeader(height: size.height * 0.16),

          // Bottom Curved Content Card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: colors.onPrimaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(60),
                ),
              ),
              child: const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
                child: CreateAccountForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
