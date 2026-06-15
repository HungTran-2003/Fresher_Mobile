import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_cubit.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        SplashNavigator(context),
        context.read<AuthCubit>(),
        context.read<UserCubit>(),
        context.read<SettingRepository>(),
      ),
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late final SplashCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<SplashCubit>();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.primary,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("heelo")
          ],
        ),
      ),
    );
  }
}
