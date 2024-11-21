import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/utilities/extensions.dart';
import '/core/theme/app_color.dart';
import '../viewmodel/cubit/home_cubit.dart';
import '/generated/assets.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key, required HomeCubit vm}) : _vm = vm;

  final HomeCubit _vm;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 85.w,
      backgroundColor: AppColors.backgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Column(
            children: [
              Image.asset(
                Assets.assetsImagesLogo,
                height: 10.h,
              ),
              Gap(2.h),
              ..._vm.drawerItems(context).map(
                (item) {
                  return ListTile(
                    leading: SvgPicture.asset(
                      item.icon,
                      // width: 6.w,
                      // make it responsive with the screen size
                      width:
                          MediaQuery.of(context).size.width > 600 ? 4
                          .w : 6.w,
                      fit: BoxFit.contain,
                      colorFilter: item.icon == Assets.assetsSvgsNotification
                          ? const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            )
                          : null,
                    ),
                    title: Container(
                      margin: EdgeInsetsDirectional.only(start: 5.w),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (item.route.isEmpty) {
                        item.onTap!();
                      } else {
                        context.navigateToNamed(item.route);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
