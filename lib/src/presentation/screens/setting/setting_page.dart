import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/global/app_settings/app_settings_cubit.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/images/app_asset_image.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_cubit.dart';
import 'setting_navigator.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (context) {
        final navigator = SettingNavigator(context);
        return SettingCubit(
          authCubit: context.read<AuthCubit>(),
          appSettingsCubit: context.read<AppSettingsCubit>(),
          navigator: navigator,
        );
      },
      child: const _SettingPageContent(),
    );
  }
}

class _SettingPageContent extends StatelessWidget {
  const _SettingPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SettingCubit, SettingState>(
          listenWhen: (prev, current) => prev.status != current.status,
          listener: (context, state) {
            if (state.status.isLoading) {
              AppLoadingOverlay.show(context);
            } else {
              AppLoadingOverlay.hide();
            }
          },
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCardUser(context),
          const SizedBox(height: 16.0),
          _buildCardBiometrics(context),
          const SizedBox(height: 24.0),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildCardUser(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (prev, current) => prev.user != current.user,
      builder: (context, state) {
        return Card(
          elevation: 4,
          shadowColor: context.colors.outline.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          color: context.colors.surfaceContainer,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(48.0),
                  child: const AppAssetImage(
                    'assets/images/profile_avatar.png',
                    width: 96.0,
                    height: 96.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  state.user?.fullName ?? "Guest User",
                  style: context.textThemes.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  state.user?.userName ?? "guest",
                  style: context.textThemes.bodyMedium.copyWith(
                    color: context.colors.onSurface.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardBiometrics(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      buildWhen: (prev, current) => prev.useBiometrics != current.useBiometrics,
      builder: (context, state) {
        return Card(
          elevation: 2,
          shadowColor: context.colors.outline.withValues(alpha: 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: context.colors.surfaceContainer,
          child: SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            title: Text(
              context.s.biometricLoginTitle,
              style: context.textThemes.body16Semi.copyWith(
                color: context.colors.onSurface,
              ),
            ),
            subtitle: Text(
              context.s.biometricLoginSubtitle,
              style: context.textThemes.des12Re.copyWith(
                color: context.colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
            value: state.useBiometrics,
            onChanged: (val) => context.read<SettingCubit>().toggleBiometrics(val),
            activeColor: context.colors.primaryLight,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return AppFilledButton(
      title: context.s.logout,
      onPressed: () => context.read<SettingCubit>().logout(context)
    );
  }
}
