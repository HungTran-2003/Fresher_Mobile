import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/screens/main/widget/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final contentBgColor = isLight
        ? colors.onPrimaryContainer
        : colors.primaryContainer;

    return Scaffold(
      backgroundColor: colors.primaryContainer,
      body: SafeArea(bottom: false, child: navigationShell),
      bottomNavigationBar: Container(
        color: contentBgColor,
        child: SafeArea(
          top: false,
          child: AppBottomNav(
            selectedIndex: navigationShell.currentIndex,
            onIndexChanged: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
          ),
        ),
      ),
    );
  }
}
