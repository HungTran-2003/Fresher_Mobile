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
      _BottomNavItem(icon: LucideIcons.home, label: 'Home'),
      _BottomNavItem(icon: LucideIcons.settings, label: 'Setting'),
    ];

    return Container(
      height: 64, // Tăng chiều cao để chứa cả Icon và Text theo chiều dọc
      margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black0.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = selectedIndex == index;
          final activeColor = colors.primary;
          final inactiveColor = colors.onSurface.withValues(alpha: 0.4);

          return Expanded(
            child: GestureDetector(
              onTap: () => onIndexChanged(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 22,
                      color: isSelected ? activeColor : inactiveColor,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.label,
                      style: context.textThemes.bodySmall.copyWith(
                        color: isSelected ? activeColor : inactiveColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 11,
                      ),
                    ),
                  ],
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
  final String label;

  const _BottomNavItem({required this.icon, required this.label});
}
