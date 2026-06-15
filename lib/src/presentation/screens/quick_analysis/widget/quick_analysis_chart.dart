import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class QuickAnalysisChart extends StatelessWidget {
  const QuickAnalysisChart({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textThemes = context.textThemes;

    // Hardcode premium mint/pastel green background for the card as in the mockups
    final cardBgColor = const Color(0xFFE2F3EE);
    // Dark green label color inside the card
    final darkTealColor = const Color(0xFF0E3E3E);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header inside Card (April Expenses & Action buttons)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.s.aprilExpenses,
                style: textThemes.titleMedium.copyWith(
                  color: darkTealColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  _buildCircleButton(LucideIcons.search),
                  const SizedBox(width: 8),
                  _buildCircleButton(LucideIcons.calendar),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Double Bar Chart Container
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                maxY: 15,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: darkTealColor.withValues(alpha: 0.1),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        String text = '';
                        if (value == 1) text = '1k';
                        if (value == 5) text = '5k';
                        if (value == 10) text = '10k';
                        if (value == 15) text = '15k';

                        return SideTitleWidget(
                          meta: meta,
                          space: 4,
                          child: Text(
                            text,
                            style: TextStyle(
                              color: darkTealColor.withValues(alpha: 0.5),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        String text = '';
                        switch (value.toInt()) {
                          case 0:
                            text = '1st Week';
                            break;
                          case 1:
                            text = '2nd Week';
                            break;
                          case 2:
                            text = '3rd Week';
                            break;
                          case 3:
                            text = '4th Week';
                            break;
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 8,
                          child: Text(
                            text,
                            style: TextStyle(
                              color: darkTealColor.withValues(alpha: 0.8),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeBarGroup(0, 2.5, 4.5, colors.primary, colors.secondary),
                  _makeBarGroup(1, 2.8, 7.2, colors.primary, colors.secondary),
                  _makeBarGroup(2, 4.8, 11.5, colors.primary, colors.secondary),
                  _makeBarGroup(3, 8.2, 6.0, colors.primary, colors.secondary),
                ],
                barTouchData: BarTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Color(0xFF00D09E), // Vibrant green button matching the mockup
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: const Color(0xFF0E3E3E), // Dark green icon inside circle
          size: 16,
        ),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(
    int x,
    double y1,
    double y2,
    Color color1,
    Color color2,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: color1,
          width: 8,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
        BarChartRodData(
          toY: y2,
          color: color2,
          width: 8,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
      barsSpace: 4,
    );
  }
}
