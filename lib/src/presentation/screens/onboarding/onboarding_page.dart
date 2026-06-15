import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/domain/models/enum/onboarding_step.dart';
import 'package:finance/src/domain/repositories/setting_repository.dart';
import 'package:finance/src/presentation/screens/onboarding/widget/onboarding_page_view.dart';
import 'package:finance/src/presentation/widgets/inputs/buttons/app_button_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_cubit.dart';
import 'onboarding_navigator.dart';
import 'onboarding_state.dart';
import 'widget/onboarding_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) {
        final navigator = OnboardingNavigator(context);
        return OnboardingCubit(
          settingRepository: context.read<SettingRepository>(),
          navigator: navigator,
        );
      },
      child: const _OnboardingPageContent(),
    );
  }
}

class _OnboardingPageContent extends StatefulWidget {
  const _OnboardingPageContent();

  @override
  State<_OnboardingPageContent> createState() => _OnboardingPageContentState();
}

class _OnboardingPageContentState extends State<_OnboardingPageContent> {
  late final OnboardingCubit _cubit;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _cubit = context.read<OnboardingCubit>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryContainer,
      body: _buildBodyPage(context),
    );
  }

  Widget _buildBodyPage(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: maxHeight * 0.7,
            decoration: BoxDecoration(
              color: context.colors.onPrimaryContainer,
              borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
            ),
          ),
        ),

        Positioned.fill(child: _buildPageView(context)),

        Positioned(bottom: 30, child: _buildNextButton(context)),
      ],
    );
  }

  Widget _buildPageView(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _cubit.onPageChanged,
      itemCount: OnboardingStep.values.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return OnboardingPageView(page: OnboardingStep.values[index]);
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Column(
          spacing: 16,
          children: [
            OnboardingIndicator(
              totalDots: OnboardingStep.values.length,
              controller: _pageController,
              dotSize: 12,
              spacing: 8.0,
            ),
            AppButtonWrapper(
              onPressed: () {
                _cubit.next(_pageController);
              },
              child: Text(
                context.s.next,
                style: context.textThemes.headlineMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
