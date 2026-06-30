import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/presentation/global/app_settings/app_settings_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/images/app_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingController>();
    _triggerLoadingOverlay(controller, context);

    return Scaffold(body: SafeArea(child: _buildBody(context)));
  }

  void _triggerLoadingOverlay(
    SettingController controller,
    BuildContext context,
  ) {
    ever(controller.state.status, (status) {
      if (status == LoadStatus.loading) {
        AppLoadingOverlay.show(context);
      } else {
        AppLoadingOverlay.hide();
      }
    });
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
    final userController = Get.find<UserController>();
    return Obx(() {
      final user = userController.state.user.value;
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
                user?.fullName ?? "Guest User",
                style: context.textThemes.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                user?.userName ?? "guest",
                style: context.textThemes.bodyMedium.copyWith(
                  color: context.colors.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCardBiometrics(BuildContext context) {
    final appSettingsController = Get.find<AppSettingsController>();
    return Obx(() {
      final useBiometrics = appSettingsController.state.useBiometrics.value;
      return Card(
        elevation: 2,
        shadowColor: context.colors.outline.withValues(alpha: 0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: context.colors.surfaceContainer,
        child: SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
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
          value: useBiometrics,
          onChanged: (val) => controller.toggleBiometrics(val),
          activeColor: context.colors.primaryLight,
        ),
      );
    });
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colors.errorContainer,
        foregroundColor: context.colors.errorText,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      icon: const Icon(Icons.logout),
      label: Text(
        context.s.logout,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
      onPressed: () => controller.logout(),
    );
  }
}
