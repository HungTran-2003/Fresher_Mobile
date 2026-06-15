import 'package:finance/src/core/routes/router.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/domain/repositories/transaction_repository.dart';
import 'package:finance/src/presentation/screens/home/home_cubit.dart';
import 'package:finance/src/presentation/screens/home/home_navigator.dart';
import 'package:finance/src/presentation/screens/home/widget/home_filter_bar.dart';
import 'package:finance/src/presentation/screens/home/widget/home_header.dart';
import 'package:finance/src/presentation/screens/home/widget/home_savings_card.dart';
import 'package:finance/src/presentation/screens/home/widget/home_transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) {
        final navigator = HomeNavigator(context);
        final transactionRepository =
            RepositoryProvider.of<TransactionRepository>(context);
        return HomeCubit(
          navigator: navigator,
          transactionRepository: transactionRepository,
        );
      },
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final contentBgColor = isLight
        ? colors.onPrimaryContainer
        : colors.primaryContainer;

    return Column(
      children: [
        // Premium Header (Greeting, balance, progress bar)
        const HomeHeader()
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: -0.05, curve: Curves.easeOutQuad),

        // Main Content Area with elegant curved corners
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
                  // Savings On Goals Card
                  GestureDetector(
                        onTap: () => context.go(AppRouters.quickAnalysis),
                        child: const HomeSavingsCard(),
                      )
                      .animate()
                      .fadeIn(delay: 150.ms, duration: 400.ms)
                      .slideY(begin: 0.05, curve: Curves.easeOutQuad),
                  const SizedBox(height: 24),

                  // Segmented filter tabs
                  BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (prev, current) =>
                        prev.selectedFilter != current.selectedFilter,
                    builder: (context, state) {
                      return HomeFilterBar(
                        selectedFilter: state.selectedFilter,
                        onFilterChanged: (filter) {
                          context.read<HomeCubit>().changeFilter(filter);
                        },
                      );
                    },
                  ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
                  const SizedBox(height: 24),

                  // Recent Transaction list
                  const HomeTransactionList()
                      .animate()
                      .fadeIn(delay: 350.ms, duration: 400.ms)
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
