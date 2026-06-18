import 'package:crud_app/src/presentation/screens/home/home_page.dart';
import 'package:crud_app/src/presentation/screens/setting/setting_page.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_page.dart';
import 'package:crud_app/src/presentation/screens/login/login_page.dart';
import 'package:crud_app/src/presentation/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouters {
  AppRouters._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    routes: _routes,
    debugLogDiagnostics: true,
    navigatorKey: navigationKey,
    errorBuilder: (context, state) => const SplashPage(),
  );

  static String? _pendingDeepLink;

  static String? consumePendingDeepLink() {
    final pending = _pendingDeepLink;
    _pendingDeepLink = null;
    return pending;
  }

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String createAccount = '/create-account';
  static const String forgotPassword = '/forgot-password';

  // Main Tabs
  static const String home = '/home';
  static const String profile = '/setting';

  static final _routes = <RouteBase>[
    GoRoute(
      path: splash,
      name: splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: welcome,
      name: welcome,
      builder: (context, state) => const LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: home,
              name: home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: profile,
              name: profile,
              builder: (context, state) => const SettingPage(),
            ),
          ],
        ),
      ],
    ),
  ];
}
