import 'package:finance/src/core/routes/router.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textThemes = context.textThemes;

    final items = [
      _MenuModel(
        title: context.s.editProfile,
        icon: LucideIcons.user,
        isHighlight: false,
        action: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Edit Profile coming soon!')),
          );
        },
      ),
      _MenuModel(
        title: context.s.security,
        icon: LucideIcons.shieldCheck,
        isHighlight: false,
        action: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Security settings coming soon!')),
          );
        },
      ),
      _MenuModel(
        title: context.s.settings,
        icon: LucideIcons.settings,
        isHighlight: true, // Settings is highlighted with a solid blue circle in the mockup
        action: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('App Settings coming soon!')),
          );
        },
      ),
      _MenuModel(
        title: context.s.help,
        icon: LucideIcons.headset, // Custom support headset icon matching the mockup
        isHighlight: false,
        action: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Customer Support coming soon!')),
          );
        },
      ),
      _MenuModel(
        title: context.s.logout,
        icon: LucideIcons.logOut,
        isHighlight: false,
        action: () {
          // Trigger dynamic logout and session reset
          context.read<AuthCubit>().setAuthenticated(false);
          context.go(AppRouters.welcome);
        },
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final item = items[index];

        // Circle and icon colors matching mockup:
        // Highlights: solid blue circle, white icon
        // Normal: light translucent blue circle, solid blue icon
        final circleColor = item.isHighlight
            ? colors.secondary
            : colors.secondary.withValues(alpha: 0.15);
        final iconColor = item.isHighlight
            ? Colors.white
            : colors.secondary;

        return GestureDetector(
          onTap: item.action,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              // Lead Circle Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    item.icon,
                    color: iconColor,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Menu Label
              Expanded(
                child: Text(
                  item.title,
                  style: textThemes.bodyLarge.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MenuModel {
  final String title;
  final IconData icon;
  final bool isHighlight;
  final VoidCallback action;

  const _MenuModel({
    required this.title,
    required this.icon,
    required this.isHighlight,
    required this.action,
  });
}
