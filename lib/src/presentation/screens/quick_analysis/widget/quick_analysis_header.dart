import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/screens/home/widget/home_savings_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class QuickAnalysisHeader extends StatelessWidget {
  const QuickAnalysisHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textThemes = context.textThemes;

    return Container(
      width: double.infinity,
      color: colors.primaryContainer,
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Control Bar Row (Placeholder, Title, Bell)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Placeholder for layout consistency
              const SizedBox(width: 44),

              // Localized Title: Quickly Analysis
              Text(
                context.s.quicklyAnalysis,
                style: textThemes.titleLarge.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              // Notification circle
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

          // Embedded Savings Goals Card
          const HomeSavingsCard(),
        ],
      ),
    );
  }
}
