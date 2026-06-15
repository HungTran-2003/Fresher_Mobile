import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textThemes = context.textThemes;

    return Container(
      width: double.infinity,
      color: colors.primaryContainer,
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 20.0),
      child: Column(
        children: [
          // Navigation control bar (Back button, Title, Bell notification)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Placeholder for layout consistency
              const SizedBox(width: 44),

              // Title: Profile
              Text(
                context.s.profile,
                style: textThemes.titleLarge.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              // Bell icon inside custom container
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
          const SizedBox(height: 24),

          // User avatar circular headshot with premium white border
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.8),
                width: 3.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile_avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colors.onPrimaryContainer,
                  child: Icon(
                    LucideIcons.user,
                    color: colors.onSurface,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // User Name: John Smith
          Text(
            'John Smith',
            style: textThemes.titleLarge.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),

          // User ID: 25030024
          Text(
            'ID: 25030024',
            style: textThemes.bodySmall.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
