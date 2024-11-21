import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/global/widgets/check_connectivity.dart';
import 'package:souqalgomlah_app/core/utilities/app_routes.dart';
import '/core/functions/show_cart_button_widget.dart';
import '/core/services/app_prefs.dart';
import '/core/services/cart/cart_service.dart';
import '/core/constants/app_constance.dart';
import '/core/services/services_locator.dart';
import '/features/category_details/viewmodel/category_details_cubit.dart';
import '/features/category_details/views/widgets/sub_category_page_item_widget.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';

import '../../../generated/assets.dart';

class CategoryDetailsView extends StatefulWidget {
  const CategoryDetailsView({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  final _vm = sl<CategoryDetailsCubit>();
  final wallet = sl<AppPreferences>().getLoginModel().wallet;

  @override
  void initState() {
    _vm.init(
      context: context,
      categoryId: widget.categoryId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // context.navigateToNamedWithPopUntil(
        //   AppRoutes.homeRoute,
        // );
      },
      child: BlocProvider<CategoryDetailsCubit>(
        create: (context) => _vm,
        child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
          bloc: _vm,
          builder: (context, state) {
            if (_vm.categoryModel == null && _vm.categoryError.isEmpty) {
              return Scaffold(
                appBar: AppBar(),
                body: const CheckInternetConnectionView(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: Scaffold(
                    backgroundColor: AppColors.secondBackgroundColor,
                    appBar: AppBar(
                      title: Row(
                        children: [
                          if (wallet != -1) ...[
                            SvgPicture.asset(
                              Assets.assetsSvgsWallet,
                              height: 2.h,
                              colorFilter: const ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                            Gap(1.w),
                            Text(
                              '$wallet\n${context.locale == const Locale('en') ? 'Wallet Balance' : 'رصيد محفظتك'}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Gap(5.w)
                          ],
                          Expanded(
                            child: Text(
                              _vm.categoryModel?.name ?? '',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontManager.boldFontWeight,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: CheckInternetConnectionView(
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.h,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    color:
                                        AppColors.whiteColor.withOpacity(0.5),
                                    height: 5.h,
                                    child: ListView(
                                      controller: _vm.scrollController,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        FilterChip(
                                          label: Text(
                                            kAppLanguageCode == 'ar'
                                                ? 'الكل'
                                                : 'All',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: _vm.currentPage == 0
                                                  ? AppColors.whiteColor
                                                  : AppColors.blackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          selectedColor: AppColors.primary,
                                          selected: _vm.currentPage == 0,
                                          backgroundColor: AppColors.whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: const BorderSide(
                                              color: AppColors.primary,
                                              width: 1.5,
                                            ),
                                          ),
                                          iconTheme: const IconThemeData(
                                            color: AppColors.primary,
                                          ),
                                          onSelected: (bool value) {
                                            setState(
                                              () {
                                                _vm.changePage(
                                                  context: context,
                                                  index: 0,
                                                );
                                              },
                                            );
                                          },
                                          showCheckmark: false,
                                        ),
                                        Gap(2.w),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return FilterChip(
                                              label: Text(
                                                _vm
                                                        .categoryModel
                                                        ?.subCategories[index]
                                                        .name ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: index + 1 ==
                                                          _vm.currentPage
                                                      ? AppColors.whiteColor
                                                      : AppColors.blackColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              selectedColor: AppColors.primary,
                                              selected:
                                                  index + 1 == _vm.currentPage,
                                              backgroundColor:
                                                  AppColors.whiteColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                side: const BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1.5,
                                                ),
                                              ),
                                              iconTheme: const IconThemeData(
                                                color: AppColors.primary,
                                              ),
                                              onSelected: (bool value) {
                                                setState(
                                                  () {
                                                    _vm.changePage(
                                                      context: context,
                                                      index: index + 1,
                                                    );
                                                  },
                                                );
                                              },
                                              showCheckmark: false,
                                            );
                                          },
                                          separatorBuilder: (ctx, index) =>
                                              Gap(2.w),
                                          itemCount: _vm.categoryModel
                                                  ?.subCategories.length ??
                                              0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(2.h),
                                  Expanded(
                                    child: PageView.builder(
                                      controller: _vm.pageController,
                                      onPageChanged: (value) {
                                        _vm.changePage(
                                          context: context,
                                          index: value,
                                        );
                                      },
                                      itemCount: (_vm.categoryModel!
                                              .subCategories.length +
                                          1),
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return SubCategoryPageItemWidget(
                                            products: _vm.getAllProduct(),
                                            categoryDetailsCubit: _vm,
                                          );
                                        } else {
                                          return SubCategoryPageItemWidget(
                                            categoryDetailsCubit: _vm,
                                            products: _vm
                                                    .categoryModel
                                                    ?.subCategories[index - 1]
                                                    .products ??
                                                [],
                                          );
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (sl<CartService>().getCartItems().isNotEmpty)
                            BlocBuilder<CategoryDetailsCubit,
                                CategoryDetailsState>(
                              builder: (context, state) {
                                return showCartButtonWidget(
                                  context: context,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.cartRoute,
                                    ).then(
                                      (value) => setState(
                                        () {
                                          log("returned from cart");
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
