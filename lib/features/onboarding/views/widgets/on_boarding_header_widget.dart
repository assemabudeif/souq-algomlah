import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/extensions.dart';
import '/core/utilities/font_manager.dart';
import '/features/onboarding/viewmodel/on_boarding_cubit.dart';
import '/generated/assets.dart';
import '/generated/locale_keys.g.dart';

class OnBoardingHeaderWidget extends StatelessWidget {
  const OnBoardingHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 2.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            Assets.assetsImagesLogo,
            height: 10.h,
          ),
          TextButton(
            onPressed: () {
              sl<OnBoardingCubit>().skipOnBoarding(context);
            },
            child: Text(
              LocaleKeys.general_skip.tr(),
              style: context.textTheme.bodyLarge!.copyWith(
                color: context.theme.primaryColor,
                fontSize: 18.sp,
                fontWeight: FontManager.semiBoldFontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
