import 'package:finance/src/core/assets/app_vectors.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/widgets/images/app_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeBalanceOverview extends StatelessWidget {
  const HomeBalanceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textThemes = context.textThemes;

    return Column(
      children: [
        Row(
          children: [
            // Total Balance
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildBudgetTypeIcon(AppVectors.icUp, context),
                      const SizedBox(width: 4),
                      Text(
                        context.s.totalBalance,
                        style: textThemes.bodySmall.copyWith(
                          color: colors.outlineLightest,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$7,783.00',
                    style: textThemes.headlineMedium.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),

            // Vertical Divider
            Container(
              height: 40,
              width: 1.5,
              color: colors.onSurface.withValues(alpha: 0.15),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),

            // Total Expense
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildBudgetTypeIcon(AppVectors.icDown, context),
                      const SizedBox(width: 4),
                      Text(
                        context.s.totalExpense,
                        style: textThemes.bodySmall.copyWith(
                          color: colors.outlineLightest,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '-\$1,187.40',
                    style: textThemes.headlineMedium.copyWith(
                      color: colors.secondary, // Dynamic blue
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Budget Progress Bar Capsule
        Container(
          width: double.infinity,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Inner filled part (30%)
              FractionallySizedBox(
                widthFactor: 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Center(
                    child: Text(
                      '30%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Remaining budget text on the right
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    '\$20,000.00',
                    style: TextStyle(
                      color: const Color(0xFF1E293B).withValues(alpha: 0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Checkmark text: 30% Of Your Expenses, Looks Good.
        Row(
          children: [
            Icon(LucideIcons.checkSquare, color: colors.onSurface, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                context.s.expensesLooksGood,
                style: textThemes.bodySmall.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBudgetTypeIcon(String name, BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: context.colors.outlineLightest, width: 1),
      ),
      padding: const EdgeInsets.all(2),
      child: Center(
        child: AppSvgImage(
          name,
          colorFilter: ColorFilter.mode(
            context.colors.outlineLightest,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
