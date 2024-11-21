import 'package:flutter/material.dart';

class OnBoardingPageItemWidget extends StatelessWidget {
  const OnBoardingPageItemWidget({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset(
            image,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
        ),
        // SizedBox(height: 5.h),
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(
        //       horizontal: 8.w,
        //       vertical: 2.h,
        //     ),
        //     child: Text(
        //       title,
        //       style: context.textTheme.bodyLarge!.copyWith(
        //         fontSize: 18.sp,
        //         fontWeight: FontManager.semiBoldFontWeight,
        //       ),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
