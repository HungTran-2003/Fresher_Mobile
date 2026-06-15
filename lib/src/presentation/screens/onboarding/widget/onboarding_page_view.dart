import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/domain/models/enum/onboarding_step.dart';
import 'package:flutter/material.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingStep page;
  const OnboardingPageView({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    return Column(
      spacing: 20,
      children: [
        SizedBox(
          height: maxHeight * 0.3,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Text(
                page.getPageTitle,
                style: context.textThemes.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        page.getPageImageLogo,
      ],
    );
  }
}
