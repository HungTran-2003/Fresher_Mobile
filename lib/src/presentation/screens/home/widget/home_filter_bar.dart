import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/domain/models/enum/filter_time.dart';
import 'package:flutter/material.dart';

class HomeFilterBar extends StatelessWidget {
  final FilterTime selectedFilter;
  final ValueChanged<FilterTime> onFilterChanged;

  const HomeFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      decoration: BoxDecoration(
        color: colors.filterBar,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: FilterTime.values.map((filter) {
          final isSelected = selectedFilter == filter;

          return Expanded(
            child: GestureDetector(
              onTap: () => onFilterChanged(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Center(
                  child: Text(
                    filter.label,
                    style: context.textThemes.bodyMedium,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
