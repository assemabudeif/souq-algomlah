import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/enums/languaage_enum.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';

class SelectLanguageItemWidget extends StatelessWidget {
  const SelectLanguageItemWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.languageName,
    required this.selected,
  });
  final LanguageEnum value;
  final bool selected;
  final Function(LanguageEnum) onChanged;
  final String title;
  final String languageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontManager.boldFontWeight,
          ),
        ),
        Gap(1.h),
        Container(
          width: 35.w,
          height: 7.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: selected ? AppColors.lightPrimary : AppColors.lightGreyColor,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.w),
            onTap: () {
              onChanged(value);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  languageName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontManager.mediumFontWeight,
                    color:
                        selected ? AppColors.primary : AppColors.lightTextColor,
                  ),
                ),
                Gap(2.w),
                Container(
                    width: 5.w,
                    height: 5.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(1.w),
                      border: Border.all(
                        color: !selected
                            ? AppColors.borderColor
                            : AppColors.transparentColor,
                      ),
                      color: selected
                          ? AppColors.primary
                          : AppColors.lightGreyColor,
                    ),
                    child: selected
                        ? Icon(
                            Icons.check,
                            color: AppColors.whiteColor,
                            size: 3.w,
                          )
                        : Container()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
