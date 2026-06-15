import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/screens/home/widget/home_transaction_list.dart';
import 'package:finance/src/presentation/screens/quick_analysis/quick_analysis_cubit.dart';
import 'package:finance/src/presentation/screens/quick_analysis/quick_analysis_navigator.dart';
import 'package:finance/src/presentation/screens/quick_analysis/widget/quick_analysis_chart.dart';
import 'package:finance/src/presentation/screens/quick_analysis/widget/quick_analysis_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickAnalysisPage extends StatelessWidget {
  const QuickAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuickAnalysisCubit>(
      create: (context) {
        final navigator = QuickAnalysisNavigator(context);
        return QuickAnalysisCubit(navigator: navigator);
      },
      child: const _QuickAnalysisPageContent(),
    );
  }
}

class _QuickAnalysisPageContent extends StatelessWidget {
  const _QuickAnalysisPageContent();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final contentBgColor = isLight
        ? colors.onPrimaryContainer
        : colors.primaryContainer;

    return Column(
      children: [
        // Control Header with Back Button and embedded Goals Card
        const QuickAnalysisHeader()
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: -0.05, curve: Curves.easeOutQuad),

        // Curved sheet containing analysis details
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: contentBgColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(44),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 16.0),
              child: Column(
                children: [
                  // "April Expenses" Dual Bar Chart
                  const QuickAnalysisChart()
                      .animate()
                      .fadeIn(delay: 150.ms, duration: 400.ms)
                      .slideY(begin: 0.05, curve: Curves.easeOutQuad),
                  const SizedBox(height: 24),

                  // Reuse high-fidelity transaction rows list
                  const HomeTransactionList()
                      .animate()
                      .fadeIn(delay: 250.ms, duration: 400.ms)
                      .slideY(begin: 0.05, curve: Curves.easeOutQuad),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
