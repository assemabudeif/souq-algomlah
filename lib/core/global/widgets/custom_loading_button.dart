import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.height,
    this.width,
  });

  final Function onPressed;
  final String text;
  final Color? backgroundColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return EasyButton(
      onPressed: () {
        return onPressed();
      },
      type: EasyButtonType.elevated,
      borderRadius: 10.w,
      buttonColor: backgroundColor ?? AppColors.primary,
      height: height ?? 6.h,
      width: width ?? 100.w,
      idleStateWidget: Text(text),
      loadingStateWidget: const CircularProgressIndicator(
        color: AppColors.whiteColor,
      ),
    );
  }
}
