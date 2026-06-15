import 'package:finance/src/core/utils/category_utils.dart';
import 'package:finance/src/core/utils/date_utils.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/data/response/transaction_response.dart';
import 'package:finance/src/presentation/widgets/divider/app_divider.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final TransactionResponse item;

  const TransactionItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textThemes = context.textThemes;

    final isIncome = item.type.toLowerCase() == 'income';

    final displayType = isIncome ? context.s.income : context.s.expense;

    final displayAmount = isIncome ? '+${item.amount}' : '-${item.amount}';

    final iconData = CategoryUtils.getCategoryIcon(item.iconKey ?? '');

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colors.secondary,
            shape: BoxShape.circle,
          ),
          child: Center(child: SizedBox(width: 24, child: iconData)),
        ),
        const SizedBox(width: 14),

        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.categoryName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textThemes.bodyLarge.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateTimeUtils.formatDate(item.date),
                style: textThemes.bodySmall.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        AppDivider(
          isVertical: true,
          thickness: 1,
          color: colors.primary,
          length: 40,
        ),

        // Group Label
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              displayType,
              style: textThemes.bodyMedium.copyWith(
                color: colors.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),

        AppDivider(
          isVertical: true,
          thickness: 1,
          color: colors.primary,
          length: 40,
        ),

        // Amount
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              displayAmount,
              style: TextStyle(
                color: isIncome ? colors.onSurface : colors.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 14.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
