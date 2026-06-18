import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final items = [
      _BottomNavItem(icon: LucideIcons.home, tooltip: 'Home'),
      _BottomNavItem(icon: LucideIcons.settings, tooltip: 'Setting'),
    ];

    return Container(
      height: 64,
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: colors.outline, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onIndexChanged(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.fastOutSlowIn,
                padding: isSelected
                    ? const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      )
                    : const EdgeInsets.all(12.0),
                decoration: isSelected
                    ? BoxDecoration(
                        color: colors.primaryLight,
                        borderRadius: BorderRadius.circular(24),
                      )
                    : null,
                child: Icon(
                  item.icon,
                  size: 24,
                  color: isSelected
                      ? colors.onSurfaceLight
                      : colors.onSurface.withValues(alpha: 0.65),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BottomNavItem {
  final IconData icon;
  final String tooltip;

  const _BottomNavItem({required this.icon, required this.tooltip});
}
