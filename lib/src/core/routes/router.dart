
import 'package:crud_app/src/presentation/screens/splash/splash_page.dart';
import 'package:crud_app/src/presentation/screens/login/login_page.dart';
import 'package:crud_app/src/presentation/screens/home/home_page.dart';
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
  static const String quickAnalysis = '/quick-analysis';
  static const String transfer = '/transfer';
  static const String layers = '/layers';
  static const String profile = '/profile';

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
    GoRoute(
      path: home,
      name: home,
      builder: (context, state) => const HomePage(),
    ),
  ];
}
