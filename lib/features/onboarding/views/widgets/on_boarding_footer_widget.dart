import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/extensions.dart';
import '/core/utilities/font_manager.dart';
import '/features/onboarding/viewmodel/on_boarding_cubit.dart';
import '/generated/locale_keys.g.dart';

class OnBoardingFooterWidget extends StatelessWidget {
  const OnBoardingFooterWidget({super.key, required this.vm});

  final OnBoardingCubit vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      bloc: vm,
      builder: (context, state) {
        return SizedBox(
          height: 20.h,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Visibility(
                visible: false,
                child: SizedBox(
                  width: 10.w,
                  child: Visibility(
                    visible: vm.currentPage == 1,
                    child: IconButton(
                      onPressed: () {
                        vm.previousPage();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 3.8.w,
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              if (vm.currentPage != vm.onBoardingPages.length - 1)
                AnimatedSmoothIndicator(
                  activeIndex: vm.currentPage,
                  count: vm.onBoardingPages.length,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    spacing: 3.w,
                    dotWidth: 4.w,
                    dotHeight: 2.5.w,
                    activeDotColor: context.theme.primaryColor,
                    dotColor: context.theme.primaryColor.withOpacity(0.5),
                  ),
                ),
              if (vm.currentPage == vm.onBoardingPages.length - 1)
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      onPressed: () {
                        vm.skipOnBoarding(context);
                      },
                      color: AppColors.primary,
                      height: 7.h,
                      minWidth: 22.w,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Text(
                        LocaleKeys.onboarding_start.tr(),
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontManager.mediumFontWeight,
                        ),
                      ),
                    ),
                  ),
                ),
              if (vm.currentPage != vm.onBoardingPages.length - 1)
                SizedBox(
                  width: 10.w,
                  child: IconButton(
                    onPressed: () {
                      vm.nextPage();
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 3.8.w,
                      color: context.theme.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
