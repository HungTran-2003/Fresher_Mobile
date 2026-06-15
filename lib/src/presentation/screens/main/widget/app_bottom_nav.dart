import 'package:finance/src/core/utils/extensions/context_extensions.dart';
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
    final isLight = Theme.of(context).brightness == Brightness.light;

    // Premium dynamic background matching the mockups:
    // Light mode: `#DFF7E2` (colors.onPrimary)
    // Dark mode: `#093030` (colors.onPrimaryContainer)
    final navBgColor = isLight ? colors.onPrimary : colors.onPrimaryContainer;

    final items = [
      _BottomNavItem(icon: LucideIcons.home, tooltip: 'Home'),
      _BottomNavItem(icon: LucideIcons.barChart3, tooltip: 'Analyze'),
      _BottomNavItem(icon: LucideIcons.arrowLeftRight, tooltip: 'Transfer'),
      _BottomNavItem(icon: LucideIcons.layers, tooltip: 'Layers'),
      _BottomNavItem(icon: LucideIcons.user, tooltip: 'Profile'),
    ];

    return Container(
      height: 72,
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: navBgColor,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isLight ? 0.04 : 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
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
              child: Center(
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
                          color:
                              colors.primary, // Vibrant `#00D09E` in both modes
                          borderRadius: BorderRadius.circular(24),
                        )
                      : null,
                  child: Icon(
                    item.icon,
                    size: 24,
                    color: isSelected
                        ? colors
                              .onSurfaceLight // Dark teal/slate `#0E3E3E` inside vibrant green capsule
                        : colors.onSurface.withValues(alpha: 0.65),
                  ),
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
