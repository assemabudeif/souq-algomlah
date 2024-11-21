import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/features/onboarding/model/onboarding_model.dart';
import '/generated/assets.dart';
import '/generated/locale_keys.g.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  final PageController pageController = PageController();
  int currentPage = 0;

  final List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
      image: Assets.assetsImagesSs1,
      title: LocaleKeys.onboarding_first.tr(),
    ),
    OnBoardingModel(
      image: Assets.assetsImagesSs2,
      title: LocaleKeys.onboarding_second.tr(),
    ),
  ];

  void nextPage() {
    if (pageController.page!.toInt() == onBoardingPages.length - 1) {
      return;
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    emit(OnBoardingNextPageState());
  }

  void previousPage() {
    if (pageController.page!.toInt() == 0) {
      return;
    } else {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    emit(OnBoardingPreviousPageState());
  }

  void onPageChanged(int index) {
    emit(OnBoardingInitial());
    currentPage = index;
    log('index: $currentPage');
    emit(OnBoardingPageChangedState());
  }

  void skipOnBoarding(BuildContext context) =>
      context.navigateToNamedWithPopUntil(AppRoutes.languageRoute);
}
