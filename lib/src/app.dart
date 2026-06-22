import 'dart:developer';

import 'package:crud_app/configs/app_config.dart';
import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/core/routes/router.dart';
import 'package:crud_app/src/data/repositories/auth_repository_impl.dart';
import 'package:crud_app/src/data/services/network/dio_client.dart';
import 'package:crud_app/src/presentation/global/app_settings/app_settings_cubit.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/core/routes/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/setting_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/models/enum/language.dart';
import 'data/services/hive/auth/hive_service.dart';
import 'data/services/firebase/auth/firebase_service.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/setting_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final DioClient dioClient;

  @override
  void initState() {
    super.initState();
    dioClient = DioClient.instance;
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            hiveService: HiveService(),
            firebaseService: FirebaseService(),
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            hiveService: HiveService(),
          ),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(
            dioClient: DioClient.instance,
          ),
        ),
        RepositoryProvider<SettingRepository>(
          create: (context) {
            return SettingRepositoryImpl();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppSettingsCubit>(
            create: (context) {
              final settingRepository =
                  RepositoryProvider.of<SettingRepository>(context);
              return AppSettingsCubit(settingRepository: settingRepository)
                ..getInitialSetting();
            },
          ),

          BlocProvider<AuthCubit>(
            create: (context) {
              return AuthCubit(authRepo: context.read<AuthRepository>());
            },
          ),

          BlocProvider<UserCubit>(
            create: (context) {
              return UserCubit(context.read<UserRepository>());
            },
          ),
        ],
        child: const AppContent(),
      ),
    );
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
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      buildWhen: (prev, current) {
        return prev.language != current.language ||
            prev.themeMode != current.themeMode;
      },
      builder: (context, state) {
        log('Language: ${state.language.code}, ThemeMode: ${state.themeMode}');

        return BlocListener<AuthCubit, AuthState>(
          listenWhen: (prev, current) =>
              prev.isAuthenticated != current.isAuthenticated,
          listener: (context, state) {
            if (state.isAuthenticated) {
              AppLoadingOverlay.hide();
              Get.offAllNamed(AppRouters.home);
            } else {
              AppLoadingOverlay.hide();
              Get.offAllNamed(AppRouters.welcome);
            }
          },
          child: GestureDetector(
            onTap: () {
              _hideKeyboard(context);
            },
            child: _buildMaterialApp(
              locale: state.language.local,
              themeMode: state.themeMode,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMaterialApp({
    required Locale locale,
    required ThemeMode themeMode,
  }) {
    final lightTheme = LightThemeData();
    final darkTheme = DarkThemeData();

    // Select which custom theme to provide via AppTheme
    // If system, we'd ideally want to match platform brightness
    final isDark =
        themeMode == ThemeMode.dark ||
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
