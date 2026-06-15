import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/core/utils/time_utils.dart';
import 'package:finance/src/presentation/global/app_settings/app_settings_cubit.dart';
import 'package:finance/src/presentation/screens/home/widget/home_balance_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textThemes = context.textThemes;
    final greeting = TimeGreeting.fromDateTime(
      DateTime.now(),
    ).getGreeting(context);

    return Container(
      width: double.infinity,
      color: colors.primaryContainer,
      padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.s.hiWelcomeBack, style: textThemes.titleLarge),
                  const SizedBox(height: 2),
                  Text(greeting, style: textThemes.bodyMedium),
                ],
              ),
              Row(
                children: [
                  // Neat Theme toggle button
                  BlocBuilder<AppSettingsCubit, AppSettingsState>(
                    builder: (context, state) {
                      final isDark = state.themeMode == ThemeMode.dark;
                      return IconButton(
                        icon: Icon(
                          isDark ? LucideIcons.sun : LucideIcons.moon,
                          color: colors.onSurface,
                        ),
                        onPressed: () {
                          context.read<AppSettingsCubit>().changeThemeMode(
                            themeMode: isDark
                                ? ThemeMode.light
                                : ThemeMode.dark,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  // Bell notification button
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.onPrimaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        LucideIcons.bell,
                        color: colors.onSurface,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 36),

          const HomeBalanceOverview(),
        ],
      ),
    );
  }
}
