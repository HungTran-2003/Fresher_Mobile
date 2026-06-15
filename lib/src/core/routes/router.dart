import 'package:finance/src/presentation/screens/auth/create_account/create_account_page.dart';
import 'package:finance/src/presentation/screens/auth/forgot_password/forgot_password_page.dart';
import 'package:finance/src/presentation/screens/home/home_page.dart';
import 'package:finance/src/presentation/screens/main/main_page.dart';
import 'package:finance/src/presentation/screens/onboarding/onboarding_page.dart';
import 'package:finance/src/presentation/screens/profile/profile_page.dart';
import 'package:finance/src/presentation/screens/quick_analysis/quick_analysis_page.dart';
import 'package:finance/src/presentation/screens/splash/splash_page.dart';
import 'package:finance/src/presentation/screens/auth/sign_in/welcome_page.dart';
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
      path: onboarding,
      name: onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: welcome,
      name: welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: createAccount,
      name: createAccount,
      builder: (context, state) => const CreateAccountPage(),
    ),
    GoRoute(
      path: forgotPassword,
      name: forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
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
              path: quickAnalysis,
              name: quickAnalysis,
              builder: (context, state) => const QuickAnalysisPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: transfer,
              name: transfer,
              builder: (context, state) =>
                  const Center(child: Text('Transfer')),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: layers,
              name: layers,
              builder: (context, state) => const Center(child: Text('Layers')),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: profile,
              name: profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ];
}
