import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/screens/profile/profile_cubit.dart';
import 'package:finance/src/presentation/screens/profile/profile_navigator.dart';
import 'package:finance/src/presentation/screens/profile/widget/profile_header.dart';
import 'package:finance/src/presentation/screens/profile/widget/profile_menu_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) {
        final navigator = ProfileNavigator(context);
        return ProfileCubit(navigator: navigator);
      },
      child: const _ProfilePageContent(),
    );
  }
}

class _ProfilePageContent extends StatelessWidget {
  const _ProfilePageContent();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final contentBgColor = isLight
        ? colors.onPrimaryContainer
        : colors.primaryContainer;

    return Column(
      children: [
        // Control Header with Back Button, avatar portrait, and name/ID labels
        const ProfileHeader()
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: -0.05, curve: Curves.easeOutQuad),

        // Curved sheet containing menu items
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: contentBgColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(44),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 16.0),
              child: const ProfileMenuList()
                  .animate()
                  .fadeIn(delay: 150.ms, duration: 400.ms)
                  .slideY(begin: 0.05, curve: Curves.easeOutQuad),
            ),
          ),
        ),
      ],
    );
  }
}
