import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/constants/app_constance.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/core/theme/app_color.dart';

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    super.key,
    required this.title,
    required this.categoryId,
  });

  final String title;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () {
            context.navigateToNamedWithArguments(
              AppRoutes.categoryDetailsRoute,
              categoryId,
            );
          },
          child: Text(
            kAppLanguageCode == 'ar' ? "عرض الكل" : "View All",
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
