import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/screens/main/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'main_cubit.dart';
import 'main_navigator.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) {
        final navigator = MainNavigator(context);
        return MainCubit(navigator: navigator);
      },
      child: MainChildPage(navigationShell: navigationShell),
    );
  }
}

class MainChildPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainChildPage({super.key, required this.navigationShell});

  @override
  State<MainChildPage> createState() => _MainChildPageState();
}

class _MainChildPageState extends State<MainChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(bottom: false, child: widget.navigationShell),
      bottomNavigationBar: SafeArea(
        top: false,
        child: AppBottomNav(
          selectedIndex: widget.navigationShell.currentIndex,
          onIndexChanged: (index) {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          },
        ),
      ),
    );
  }
}
