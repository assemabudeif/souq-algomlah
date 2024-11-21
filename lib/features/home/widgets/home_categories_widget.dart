import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/constants/app_constance.dart';
import '/core/data/models/category_model.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/core/theme/app_color.dart';

class HomeCategoriesWidget extends StatefulWidget {
  const HomeCategoriesWidget({
    super.key,
    required this.allCategories,
  });

  final List<CategoryModel> allCategories;

  @override
  State<HomeCategoriesWidget> createState() => _HomeCategoriesWidgetState();
}

class _HomeCategoriesWidgetState extends State<HomeCategoriesWidget> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    categories = widget.allCategories
        .where((element) => element.subCategories.isNotEmpty)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          kAppLanguageCode == 'ar' ? "تسوق حسب القسم" : "Shop by Department",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(1.5.h),
        SizedBox(
          // height: 50.h,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 2.h,
              mainAxisExtent: 14.h,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.navigateToNamedWithArguments(
                    AppRoutes.categoryDetailsRoute,
                    categories[index].id,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 8.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.whiteColor,
                      ),
                      padding: EdgeInsets.all(1.w),
                      alignment: Alignment.center,
                      child: CustomNetworkImage(
                        imageUrl: widget.allCategories[index].img.url,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Gap(1.h),
                    Text(
                      widget.allCategories[index].name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
