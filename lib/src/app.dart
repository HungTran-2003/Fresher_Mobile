import 'package:crud_app/configs/app_config.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/core/di/global_binding.dart';
import 'package:crud_app/src/core/routes/get_pages.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/core/theme/app_theme.dart';
import 'package:crud_app/src/presentation/global/app_settings/app_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _lightTheme = LightThemeData();
  final _darkTheme = DarkThemeData();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConfigs.appName,
      theme: _lightTheme.themeData,
      darkTheme: _darkTheme.themeData,
      themeMode: ThemeMode.light,
      initialRoute: AppRouters.splash,
      getPages: GetAppPages.routes,
      initialBinding: GlobalBinding(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        return Obx(() {
          final appSettingsController = Get.find<AppSettingsController>();
          final themeMode = appSettingsController.state.themeMode.value;

          final isDark = themeMode == ThemeMode.dark ||
              (themeMode == ThemeMode.system &&
                  MediaQuery.platformBrightnessOf(context) == Brightness.dark);

          final currentAppTheme = isDark ? _darkTheme : _lightTheme;

          return AppTheme(
            theme: currentAppTheme,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: currentAppTheme.systemOverlayStyle,
              child: GestureDetector(
                onTap: () => _hideKeyboard(context),
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          );
        });
      },
    );
  }

  void _hideKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}