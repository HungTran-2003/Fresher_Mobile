import 'dart:developer';

import 'package:finance/configs/app_config.dart';
import 'package:finance/generated/l10n.dart';
import 'package:finance/src/core/routes/router.dart';
import 'package:finance/src/data/repositories/auth_repository_impl.dart';
import 'package:finance/src/presentation/global/app_settings/app_settings_cubit.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:finance/src/presentation/global/user/user_cubit.dart';
import 'package:finance/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/setting_repository_impl.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/services/database/share_preferrences_data_source.dart';
import 'domain/models/enum/language.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/setting_repository.dart';
import 'domain/repositories/transaction_repository.dart';
import 'domain/repositories/user_repository.dart';

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({super.key, required this.sharedPreferences});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferencesDataSource _sharedPreferencesDataSource;

  @override
  void initState() {
    super.initState();
    _sharedPreferencesDataSource = SharedPreferencesDataSource(
      widget.sharedPreferences,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImpl(),
        ),
        RepositoryProvider<TransactionRepository>(
          create: (context) => TransactionRepositoryImpl(),
        ),

        RepositoryProvider<SettingRepository>(
          create: (context) {
            return SettingRepositoryImpl(
              sharedPreferencesDataSource: _sharedPreferencesDataSource,
            );
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
              AppRouters.router.go(AppRouters.home);
            } else {
              AppLoadingOverlay.hide();
              AppRouters.router.go(AppRouters.welcome);
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
        child: MaterialApp.router(
          title: AppConfigs.appName,
          theme: lightTheme.themeData,
          darkTheme: darkTheme.themeData,
          themeMode: themeMode,
          routerConfig: AppRouters.router,
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
