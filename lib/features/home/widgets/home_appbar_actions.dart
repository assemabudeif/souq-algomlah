import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/core/theme/app_color.dart';
import '/generated/assets.dart';

homeAppBarActions(BuildContext context) => [
      InkWell(
        onTap: () {
          context.navigateToNamed(AppRoutes.searchRoute);
        },
        child: SvgPicture.asset(
          Assets.assetsSvgsSearch,
          height: 3.5.h,
        ),
      ),
      Gap(1.w),
      SizedBox(
        width: 7.w,
        child: InkWell(
          onTap: () {
            context.navigateToNamed(AppRoutes.cartRoute);
          },
          child: Stack(
            children: [
              PositionedDirectional(
                top: 0,
                end: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  Assets.assetsSvgsCart1,
                  height: 3.5.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              PositionedDirectional(
                start: 0.5.w,
                top: -2.h,
                bottom: 0,
                child: Container(
                  height: 3.5.w,
                  width: 3.5.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    sl<CartService>().getCartItems().length.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Gap(2.w),
    ];
