import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/global/widgets/check_connectivity.dart';
import 'package:souqalgomlah_app/core/utilities/app_routes.dart';
import 'package:souqalgomlah_app/features/widgets/custom_banner_widget.dart';
import '/core/functions/show_cart_button_widget.dart';
import '/core/services/cart/cart_service.dart';
import '/features/home/widgets/home_item_widget.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '../viewmodel/cubit/home_cubit.dart';
import '/features/home/widgets/home_appbar_actions.dart';
import '/features/home/widgets/home_appbar_title.dart';
import '/features/home/widgets/home_categories_widget.dart';
import '/features/home/widgets/home_drawer_widget.dart';
import '/generated/assets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _vm = sl<HomeCubit>();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  void initState() {
    _scrollPosition();
    _vm.init(context);

    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    _vm.init(context);
  }

  _scrollPosition() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset > 100.h) {
          setState(() {
            _isScrolling = true;
          });
        } else {
          setState(() {
            _isScrolling = false;
          });
        }
      } else {
        setState(() {
          _isScrolling = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => _vm,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: _vm.scaffoldKey,
            backgroundColor: AppColors.secondBackgroundColor,
            floatingActionButton: _isScrolling
                ? Container(
                    margin: EdgeInsets.only(
                      bottom:
                          sl<CartService>().getCartItems().isNotEmpty ? 8.h : 0,
                    ),
                    child: FloatingActionButton(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      onPressed: () {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Icon(
                        Icons.arrow_upward,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  )
                : null,
            drawer: HomeDrawerWidget(vm: _vm),
            appBar: AppBar(
              title: homeAppBarTitle(context),
              leading: BlocBuilder<HomeCubit, HomeState>(
                bloc: _vm,
                builder: (context, state) {
                  return InkWell(
                    onTap: () => _vm.openDrawer(),
                    child: Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width > 600 ? 1.w : 3.w),
                      child: SvgPicture.asset(
                        Assets.assetsSvgsHomeMenu,
                        width:
                            MediaQuery.of(context).size.width > 600 ? 4.w : 6.w,
                      ),
                    ),
                  );
                },
              ),
              actions: homeAppBarActions(context),
            ),
            body: CheckInternetConnectionView(
              child: BlocBuilder<HomeCubit, HomeState>(
                bloc: _vm,
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () {
                      return _vm.init(context);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if ((_vm.homeData == null &&
                                    _vm.homeDataError.isEmpty)) ...[
                                  const LinearProgressIndicator(),
                                  Gap(2.h),
                                ] else if (_vm.homeData != null) ...[
                                  if (_vm.mainBanners.isNotEmpty) ...[
                                    CustomBannerWidget(
                                      images: [
                                        ..._vm.mainBanners
                                            .map((element) => element.url)
                                      ],
                                      isNetworkImage: true,
                                    ),
                                    Gap(2.h),
                                  ],
                                  HomeCategoriesWidget(
                                    allCategories:
                                        _vm.homeData?.allCategories ?? [],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        _vm.homeData?.allCategories.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return HomeItemWidget(
                                        category:
                                            _vm.homeData!.allCategories[index],
                                        vm: _vm,
                                      );
                                    },
                                  ),
                                ] else
                                  Center(
                                    child: Text(
                                      _vm.homeDataError,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                const Gap(2),
                              ],
                            ),
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
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
