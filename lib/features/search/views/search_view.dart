import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/global/widgets/check_connectivity.dart';
import 'package:souqalgomlah_app/core/utilities/app_routes.dart';
import '/core/functions/show_cart_button_widget.dart';
import '/core/services/cart/cart_service.dart';

import '/generated/locale_keys.g.dart';
import '/core/constants/app_constance.dart';
import '/core/services/services_locator.dart';
import '/features/search/viewmodel/search_cubit.dart';
import '/core/theme/app_color.dart';
import '/features/home/widgets/home_product_item_widget.dart';
import '/generated/assets.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _vm = sl<SearchCubit>();

  @override
  void dispose() {
    _vm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => _vm,
      child: Scaffold(
        backgroundColor: AppColors.secondBackgroundColor,
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 2.h,
              ),
              child: TextFormField(
                controller: _vm.searchController,
                decoration: InputDecoration(
                  constraints: BoxConstraints(
                    maxHeight: 8.h,
                    minWidth: 1.h,
                  ),
                  hintText: LocaleKeys.general_search.tr(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: SvgPicture.asset(
                      Assets.assetsSvgsSearch,
                      colorFilter: const ColorFilter.mode(
                        AppColors.greyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffix: Container(
                    margin: EdgeInsets.only(top: 1.h),
                    child: InkWell(
                      onTap: () {
                        _vm.searchController.clear();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                onFieldSubmitted: (value) {
                  _vm.search();
                },
                onChanged: (value) {
                  _vm.search();
                },
              ),
            ),
            Gap(2.h),
            Expanded(
              child: CheckInternetConnectionView(
                child: BlocBuilder<SearchCubit, SearchState>(
                  bloc: _vm..search(),
                  builder: (context, state) {
                    if (_vm.products.isEmpty && _vm.searchError.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (_vm.searchError.isNotEmpty) {
                      return Center(
                        child: Text(_vm.searchError),
                      );
                    } else {
                      if (_vm.products.isEmpty) {
                        return Center(
                          child: Text(
                            kAppLanguageCode == 'ar'
                                ? 'لا يوجد منتجات'
                                : 'No Products found',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 2.h,
                              ),
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio *
                                        1.5,
                                crossAxisSpacing: 2.w,
                                mainAxisSpacing: 2.w,
                              ),
                              itemCount: _vm.products.length,
                              itemBuilder: (context, index) {
                                //TODO: Add Category ID
                                return HomeProductItemWidget(
                                  emitState: () {
                                    _vm.emitState();
                                  },
                                  product: _vm.products[index],
                                  onAddToCart: () {
                                    _vm.addToCart(
                                      context: context,
                                      product: _vm.products[index],
                                    );
                                  },
                                  onRemoveFromCart: () {
                                    _vm.removeFromCart(
                                      context: context,
                                      productId: _vm.products[index].id,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          if (sl<CartService>().getCartItems().isNotEmpty)
                            showCartButtonWidget(
                                context: context,
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, AppRoutes.cartRoute)
                                      .then((value) => setState(() {
                                            log("returned from cart");
                                          }));
                                }),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
