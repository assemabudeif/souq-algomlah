import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  final bool selected;
  final Function() onTap;

  const CustomCheckBoxWidget({
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 5.w,
        height: 5.w,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(1.w),
          border: Border.all(
            color:
                !selected ? AppColors.borderColor : AppColors.transparentColor,
          ),
          color: selected ? AppColors.primary : AppColors.lightGreyColor,
        ),
        child: selected
            ? Icon(
                Icons.check,
                color: AppColors.whiteColor,
                size: 3.w,
              )
            : Container(),
      ),
    );
  }
}
