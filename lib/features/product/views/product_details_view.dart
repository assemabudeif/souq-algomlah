import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/features/product/viewmodel/product_cubit.dart';
import '/core/functions/show_cart_button_widget.dart';
import '/core/global/widgets/check_connectivity.dart';
import '/core/utilities/app_routes.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/cart/models/cart_item_model.dart';
import '/core/services/favorite/favorite_service.dart';
import '/core/services/favorite/models/favorite_model.dart';
import '/core/services/favorite/models/hive_product_model.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/extensions.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/widgets/custom_banner_widget.dart';
import '/generated/assets.dart';
import '/generated/locale_keys.g.dart';
import 'widgets/related_product_item_widget.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.params,
  });

  final ProductParams params;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final _vm = sl<ProductCubit>();
  @override
  void initState() {
    log(widget.params.product, name: "Product Id");
    _vm.getProduct(widget.params.product, context);
    super.initState();
  }

  _addToCart() {
    setState(() {});
    if (!sl<CartService>().isItemInCart(_vm.productModel!.product.id)) {
      final product = HiveProductModel(
        // categoryId: widget.params.categoryId,
        id: _vm.productModel!.product.id,
        amount: _vm.productModel!.product.amount,
        createdAt: _vm.productModel!.product.createdAt.toString(),
        desc: _vm.productModel!.product.desc,
        englishName: _vm.productModel!.product.englishName,
        name: _vm.productModel!.product.name,
        firstImage: _vm.productModel!.product.firstImage.url,
        secondImage: _vm.productModel!.product.secondImage.url,
        isAvailable: _vm.productModel!.product.isAvailable,
        oldPrice: _vm.productModel!.product.oldPrice,
        price: _vm.productModel!.product.price,
        updatedAt: _vm.productModel!.product.updatedAt.toString(),
        v: _vm.productModel!.product.v,
        purchaseLimit: _vm.productModel!.product.purchaseLimit,
      );
      sl<CartService>().addCartItem(
        CartItemModel(
          id: product.id,
          product: product,
        ),
      );

      context.showSuccessSnackBar(
        context.locale == const Locale('ar')
            ? 'تمت اضافة المنتج إلى السلة بنجاح'
            : 'Product Added to Cart Successfully',
      );
    } else {
      context.showWarningSnackBar(
        context.locale == const Locale('ar')
            ? 'المنتج موجود في السلة'
            : 'Product already added to cart',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.params.categoryId, name: "Category Id");
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // context.navigateToNamedWithPopUntil(
        //   AppRoutes.homeRoute,
        // );
      },
      child: BlocProvider<ProductCubit>(
        create: (context) => _vm,
        child: Scaffold(
          backgroundColor: AppColors.secondBackgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            title: BlocBuilder<ProductCubit, ProductState>(
              bloc: _vm,
              builder: (context, state) {
                return Text(
                  _vm.productModel?.product.name ?? "",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontManager.blackFontWeight,
                  ),
                  maxLines: 2,
                );
              },
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: SvgPicture.asset(
            //       Assets.assetsSvgsShare,
            //       width: 6.5.w,
            //     ),
            //     splashRadius: 10.w,
            //   ),
            //   Gap(5.w),
            // ],
          ),
          body: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (_vm.productModel == null && _vm.errorText.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (_vm.errorText.isNotEmpty) {
                return Center(
                  child: Text(_vm.errorText),
                );
              } else {
                return CheckInternetConnectionView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_vm.productModel!.product.firstImage.url
                                      .isNotEmpty ||
                                  _vm.productModel!.product.secondImage.url
                                      .isNotEmpty)
                                Stack(
                                  children: [
                                    CustomBannerWidget(
                                      isNetworkImage: true,
                                      images: [
                                        if (_vm.productModel!.product.firstImage
                                            .url.isNotEmpty)
                                          _vm.productModel!.product.firstImage
                                              .url,
                                        if (_vm.productModel!.product
                                            .secondImage.url.isNotEmpty)
                                          _vm.productModel!.product.secondImage
                                              .url,
                                      ],
                                      enableInfiniteScroll: false,
                                      height: 40.h,
                                      fit: BoxFit.fitHeight,
                                      padding: EdgeInsetsDirectional.symmetric(
                                        horizontal: 10.w,
                                        vertical: 5.h,
                                      ),
                                    ),
                                    if (_vm.productModel!.product.amount <= 5)
                                      Image.asset(
                                        context.locale == const Locale('ar')
                                            ? Assets.assetsImagesSoldOutAr
                                            : Assets.assetsImagesSoldOutEn,
                                        alignment: Alignment.center,
                                        height: 40.h,
                                        width: 100.w,
                                        fit: BoxFit.cover,
                                        // fit: BoxFit.cover,
                                        // width: 100.w,
                                      ),
                                    if (_vm.productModel!.product.oldPrice >
                                        _vm.productModel!.product.price)
                                      PositionedDirectional(
                                        bottom: 6.h,
                                        end: 2.w,
                                        child: Container(
                                          height: 3.2.h,
                                          // width: 6.h,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 2.w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.dangerColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '% ${((100 - (_vm.productModel!.product.price / _vm.productModel!.product.oldPrice) * 100)).toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: AppColors.whiteColor,
                                              fontSize: 16.sp,
                                              fontWeight:
                                                  FontManager.boldFontWeight,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              Gap(2.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          context.locale == const Locale('ar')
                                              ? "${_vm.productModel!.product.price.toStringAsFixed(3)} د.ك"
                                              : "${_vm.productModel!.product.price.toStringAsFixed(3)} K.D",
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight:
                                                FontManager.boldFontWeight,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        Gap(2.w),
                                        if (_vm.productModel!.product.oldPrice >
                                            _vm.productModel!.product.price)
                                          Text(
                                            context.locale == const Locale('ar')
                                                ? "${_vm.productModel!.product.oldPrice.toStringAsFixed(3)} د.ك"
                                                : "${_vm.productModel!.product.oldPrice.toStringAsFixed(3)} K.D",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight:
                                                  FontManager.boldFontWeight,
                                              color: AppColors.primary,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor:
                                                  AppColors.primary,
                                            ),
                                          ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (sl<FavoriteService>()
                                                  .isFavorite(
                                                      widget.params.product)) {
                                                sl<FavoriteService>()
                                                    .removeFavorite(
                                                        widget.params.product);
                                              } else {
                                                final product =
                                                    HiveProductModel(
                                                  // categoryId: widget.params.categoryId,
                                                  amount: _vm.productModel!
                                                      .product.amount,
                                                  createdAt: _vm.productModel!
                                                      .product.createdAt
                                                      .toString(),
                                                  desc: _vm.productModel!
                                                      .product.desc,
                                                  firstImage: _vm.productModel!
                                                      .product.firstImage.url,
                                                  id: _vm
                                                      .productModel!.product.id,
                                                  isAvailable: _vm.productModel!
                                                      .product.isAvailable,
                                                  name: _vm.productModel!
                                                      .product.name,
                                                  oldPrice: _vm.productModel!
                                                      .product.oldPrice,
                                                  price: _vm.productModel!
                                                      .product.price,
                                                  secondImage: _vm.productModel!
                                                      .product.secondImage.url,
                                                  updatedAt: _vm.productModel!
                                                      .product.updatedAt
                                                      .toString(),
                                                  v: _vm
                                                      .productModel!.product.v,
                                                  englishName: _vm.productModel!
                                                      .product.englishName,
                                                  purchaseLimit: _vm
                                                      .productModel!
                                                      .product
                                                      .purchaseLimit,
                                                );
                                                sl<FavoriteService>()
                                                    .addFavorite(
                                                  FavoriteModel(
                                                    id: product.id,
                                                    product: product,
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            sl<FavoriteService>().isFavorite(_vm
                                                    .productModel!.product.id)
                                                ? Assets.assetsSvgsFavRed
                                                : Assets.assetsSvgsFavGrey,
                                            width: 6.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(1.h),
                                    Text(
                                      _vm.productModel!.product.name,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontManager.boldFontWeight,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Gap(3.h),
                                    Text(
                                      context.locale == const Locale('ar')
                                          ? "الكمية المتاحة: ${_vm.productModel!.product.amount}"
                                          : "Available amount: ${_vm.productModel!.product.amount}",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontManager.boldFontWeight,
                                        color: AppColors.blackColor,
                                      ),
                                    ),

                                    Gap(1.h),
                                    // Align(
                                    //   alignment: AlignmentDirectional.centerEnd,
                                    //   child: Text(
                                    //     'SKU:${_vm.productModel!.product.id}',
                                    //     style: TextStyle(
                                    //       fontSize: 16.sp,
                                    //       fontWeight: FontManager.boldFontWeight,
                                    //       color: AppColors.greyColor,
                                    //     ),
                                    //   ),
                                    // ),
                                    Gap(2.h),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: _vm.productModel!.product
                                                    .amount >
                                                5
                                            ? AppColors.availableBackgroundColor
                                            : AppColors
                                                .notAvailableBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.h,
                                      ),
                                      child: Text(
                                        _vm.productModel!.product.amount > 5
                                            ? LocaleKeys
                                                .product_details_available
                                                .tr()
                                            : LocaleKeys
                                                .product_details_not_available
                                                .tr(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight:
                                              FontManager.boldFontWeight,
                                          color:
                                              _vm.productModel!.product.amount >
                                                      5
                                                  ? AppColors.availableColor
                                                  : AppColors.notAvailableColor,
                                        ),
                                      ),
                                    ),
                                    Gap(1.h),
                                    Text(
                                      _vm.productModel!.product.desc,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontManager.boldFontWeight,
                                        color: AppColors.hintColor,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Gap(3.h),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_vm.productModel!.product.amount >
                                                5 &&
                                            !sl<CartService>().isItemInCart(
                                                _vm.productModel!.product.id)) {
                                          _addToCart();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(100.w, 7.5.h),
                                        backgroundColor:
                                            _vm.productModel!.product.amount > 5
                                                ? AppColors.primary
                                                : AppColors.greyColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.w),
                                        ),
                                      ),
                                      child: !sl<CartService>().isItemInCart(
                                              _vm.productModel!.product.id)
                                          ? Text(
                                              LocaleKeys.general_add_to_cart
                                                  .tr(),
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight:
                                                    FontManager.lightFontWeight,
                                                color: AppColors.whiteColor,
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    sl<CartService>()
                                                        .increaseQuantity(
                                                      context: context,
                                                      id: widget.params.product,
                                                      purchaseLimit: _vm
                                                          .productModel!
                                                          .product
                                                          .purchaseLimit,
                                                    );
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(Icons.add),
                                                ),
                                                Text(
                                                  sl<CartService>()
                                                      .getCartItemById(widget
                                                          .params.product)!
                                                      .quantity
                                                      .toString(),
                                                ),
                                                sl<CartService>()
                                                            .getCartItemById(
                                                                widget.params
                                                                    .product)!
                                                            .quantity !=
                                                        1
                                                    ? IconButton(
                                                        onPressed: () {
                                                          sl<CartService>()
                                                              .decreaseQuantity(
                                                            widget
                                                                .params.product,
                                                          );
                                                          setState(() {});
                                                        },
                                                        icon: const Icon(
                                                            Icons.remove),
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          sl<CartService>()
                                                              .removeCartItem(
                                                            widget
                                                                .params.product,
                                                          );
                                                          setState(() {});
                                                        },
                                                        icon: SvgPicture.asset(
                                                          Assets
                                                              .assetsSvgsDelete,
                                                          height: 7.w,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                    ),
                                    Gap(3.h),
                                    Text(
                                      LocaleKeys.general_similar_products.tr(),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontManager.boldFontWeight,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Gap(2.h),
                                    SizedBox(
                                      height: 30.h,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _vm.productModel
                                                ?.relatedProducts.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          return RelatedProductItemWidget(
                                            emitState: () {
                                              _vm.emitState();
                                            },
                                            product: _vm.productModel!
                                                .relatedProducts[index],
                                            onAddToCart: () {
                                              _addToCart();
                                            },
                                            onRemoveFromCart: () {
                                              _removeFromCart(
                                                context: context,
                                                productId: _vm.productModel!
                                                    .relatedProducts[index].id,
                                              );
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Gap(3.w);
                                        },
                                      ),
                                    ),
                                    Gap(5.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (sl<CartService>().getCartItems().isNotEmpty)
                        showCartButtonWidget(
                            context: context,
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.cartRoute)
                                  .then((value) => setState(() {
                                        log("returned from cart");
                                      }));
                            }),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _removeFromCart({
    required BuildContext context,
    required String productId,
  }) {
    setState(() {
      if (sl<CartService>().isItemInCart(productId)) {
        sl<CartService>().removeCartItem(productId);
        context.showSuccessSnackBar(
          context.locale == const Locale('ar')
              ? 'تمت ازالة المنتج من السلة بنجاح'
              : 'Product Removed from Cart Successfully',
        );
      } else {
        context.showWarningSnackBar(
          context.locale == const Locale('ar')
              ? 'المنتج غير موجود في السلة'
              : 'Product not found in cart',
        );
      }
    });
  }
}

class ProductParams {
  final String product;
  // final ProductModel product;

  // final String categoryId;

  ProductParams({
    required this.product,
    // required this.categoryId,
  });
}
