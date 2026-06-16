import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_app/src/data/services/database/secure_storage_data_source.dart';
import 'home_cubit.dart';
import 'home_navigator.dart';
import 'widget/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) {
        final navigator = HomeNavigator(context);
        return HomeCubit(
          authCubit: context.read<AuthCubit>(),
          userCubit: context.read<UserCubit>(),
          secureStorageDataSource: context.read<SecureStorageDataSource>(),
          navigator: navigator,
        )..init();
      },
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<HomeCubit, HomeState>(
          listenWhen: (prev, current) => prev.status != current.status,
          listener: (context, state) {
            if (state.status.isLoading) {
              AppLoadingOverlay.show(context);
            } else {
              AppLoadingOverlay.hide();
            }
          },
          child: const HomeContent(),
        ),
      ),
    );
  }
}
