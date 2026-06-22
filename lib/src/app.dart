import 'dart:developer';
import 'package:crud_app/configs/app_config.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/core/di/global_binding.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/domain/models/enum/language.dart';
import 'package:crud_app/src/presentation/global/app_settings/app_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/get_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const AppContent();
  }
}

class AppContent extends StatefulWidget {
  const AppContent({super.key});

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  Widget build(BuildContext context) {
    final appSettingsController = Get.find<AppSettingsController>();

    return Obx(() {
      final language = appSettingsController.state.language.value;
      final themeMode = appSettingsController.state.themeMode.value;

      log('Language: ${language.code}, ThemeMode: $themeMode');

      return GestureDetector(
        onTap: () {
          _hideKeyboard(context);
        },
        child: _buildMaterialApp(
          locale: language.local,
          themeMode: themeMode,
        ),
      );
    });
  }

  Widget _buildMaterialApp({
    required Locale locale,
    required ThemeMode themeMode,
  }) {
    final lightTheme = LightThemeData();
    final darkTheme = DarkThemeData();

    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    final currentAppTheme = isDark ? darkTheme : lightTheme;

    return AppTheme(
      theme: currentAppTheme,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: currentAppTheme.systemOverlayStyle,
        child: GetMaterialApp(
          title: AppConfigs.appName,
          theme: lightTheme.themeData,
          darkTheme: darkTheme.themeData,
          themeMode: themeMode,
          initialRoute: AppRouters.splash,
          getPages: GetAppPages.routes,
          initialBinding: GlobalBinding(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          locale: locale,
          supportedLocales: S.delegate.supportedLocales,
          builder: (context, child) {
            return child!;
          },
        ),
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
