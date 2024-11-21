import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/features/home/viewmodel/cubit/home_cubit.dart';
import '/core/data/models/category_model.dart';
import '/features/home/widgets/home_products_list_widget.dart';
import '/features/home/widgets/home_title_widget.dart';
import '/features/widgets/custom_banner_widget.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    super.key,
    required this.category,
    required this.vm,
  });

  final CategoryModel category;
  final HomeCubit vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBannerWidget(
          isNetworkImage: true,
          images: [
            category.firstBanner.url,
            category.secondBanner.url,
          ],
        ),
        Gap(2.h),
        if (category.subCategories.isNotEmpty) ...[
          HomeTitleWidget(
            title: category.name,
            categoryId: category.id,
          ),
          Gap(2.h),
          HomeProductsListWidget(
            supCategories: category.subCategories,
            vm: vm,
          ),
          Gap(2.h),
        ]
      ],
    );
  }
}
