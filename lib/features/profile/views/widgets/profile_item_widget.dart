import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '../../models/models/profile_model.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required this.model,
  });
  final ProfileViewModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model.onPressed();
      },
      child: Container(
        height: 10.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(6.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        margin: EdgeInsets.only(bottom: 1.5.h),
        child: Row(
          children: [
            Icon(
              model.icon,
              color: AppColors.primary,
              size: 7.w,
            ),
            Gap(4.w),
            Expanded(
              child: Text(
                model.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontManager.semiBoldFontWeight,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 6.w,
              color: AppColors.hintColor,
            ),
          ],
        ),
      ),
    );
  }
}
