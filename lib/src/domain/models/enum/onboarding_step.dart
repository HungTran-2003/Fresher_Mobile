import 'package:finance/generated/l10n.dart';
import 'package:finance/src/core/assets/app_vectors.dart';
import 'package:finance/src/presentation/widgets/images/app_svg_image.dart';
import 'package:flutter/cupertino.dart';

enum OnboardingStep {
  page1,
  page2;

  String get getPageTitle {
    switch (this) {
      case OnboardingStep.page1:
        return S.current.onboardingTitle1;
      case OnboardingStep.page2:
        return S.current.onboardingTitle2;
    }
  }

  Widget get getPageImageLogo {
    switch (this) {
      case OnboardingStep.page1:
        return AppSvgImage(AppVectors.onboard_1, width: 287, height: 287);
      case OnboardingStep.page2:
        return AppSvgImage(AppVectors.onboard_2, width: 287, height: 287);
    }
  }
}
