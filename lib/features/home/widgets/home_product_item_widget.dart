import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/features/product/views/product_details_view.dart';
import '/generated/locale_keys.g.dart';
import '/core/constants/app_constance.dart';
import '/core/data/models/product_model.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/favorite/favorite_service.dart';
import '/core/services/favorite/models/favorite_model.dart';
import '/core/services/favorite/models/hive_product_model.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/theme/app_color.dart';
import '/generated/assets.dart';

class HomeProductItemWidget extends StatefulWidget {
  const HomeProductItemWidget({
    super.key,
    required this.product,
    this.isFavoriteScreen = false,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    this.amount,
    required this.emitState,
  });

  final ProductModel product;
  final bool isFavoriteScreen;
  final int? amount;
  final Function onAddToCart;
  final Function onRemoveFromCart;
  final Function emitState;

  @override
  State<HomeProductItemWidget> createState() => _HomeProductItemWidgetState();
}

class _HomeProductItemWidgetState extends State<HomeProductItemWidget> {
  _addToFavorite() {
    setState(() {
      log(widget.product.id.toString());
      if (sl<FavoriteService>().isFavorite(widget.product.id)) {
        sl<FavoriteService>().removeFavorite(widget.product.id);
      } else {
        final product = HiveProductModel(
          // categoryId: widget.categoryId,
          purchaseLimit: widget.product.purchaseLimit,
          amount: widget.product.amount,
          createdAt: widget.product.createdAt,
          desc: widget.product.desc,
          firstImage: widget.product.firstImage.url,
          id: widget.product.id,
          isAvailable: widget.product.isAvailable,
          name: widget.product.name,
          oldPrice: widget.product.oldPrice,
          price: widget.product.price,
          secondImage: widget.product.secondImage.url,
          updatedAt: widget.product.updatedAt,
          v: widget.product.v,
          englishName: widget.product.enName,
        );
        sl<FavoriteService>().addFavorite(
          FavoriteModel(
            id: product.id,
            product: product,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.navigateToNamedWithArguments(
        //   AppRoutes.productDetailsRoute,
        //   widget.product,
        // );

        Navigator.of(context)
            .pushNamed(
          AppRoutes.productDetailsRoute,
          arguments: ProductParams(
            product: widget.product.id,
            // categoryId: widget.categoryId,
          ),
        )
            .then((value) {
          setState(() {
            widget.emitState();
          });
        });
      },
      child: Container(
        width: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor,
        ),
        padding: EdgeInsets.all(2.w),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _addToFavorite();
                  },
                  child: SvgPicture.asset(
                    sl<FavoriteService>().isFavorite(widget.product.id)
                        ? Assets.assetsSvgsFavRed
                        : Assets.assetsSvgsFavGrey,
                    height: 3.h,
                  ),
                ),
                if (widget.product.oldPrice > widget.product.price)
                  Container(
                    height: 3.h,
                    width: 10.h,
                    decoration: const BoxDecoration(
                      color: AppColors.dangerColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      kAppLanguageCode == 'ar'
                          ? "خصم ${((100 - (widget.product.price / widget.product.oldPrice) * 100)).toStringAsFixed(2)}%"
                          : 'Discund ${((100 - (widget.product.price / widget.product.oldPrice) * 100)).toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: SizedBox(
                width: 40.w,
                child: Stack(
                  children: [
                    Center(
                      child: CustomNetworkImage(
                        imageUrl: widget.product.firstImage.url,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    if (widget.product.amount <= 5)
                      Image.asset(
                        context.locale == const Locale('ar')
                            ? Assets.assetsImagesSoldOutAr
                            : Assets.assetsImagesSoldOutEn,
                        alignment: Alignment.center,
                        fit: BoxFit.fitWidth,
                        width: 100.w,
                      ),
                    if (widget.product.amount > 5)
                      (sl<CartService>().isItemInCart(widget.product.id))
                          ? widget.amount != null
                              ? const SizedBox.shrink()
                              : PositionedDirectional(
                                  bottom: 0,
                                  start: 0,
                                  child: Row(
                                    children: [
                                      Card(
                                        surfaceTintColor:
                                            AppColors.successColor,
                                        color: AppColors.successColor,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 3.w,
                                            vertical: 1.h,
                                          ),
                                          child: Text(
                                            sl<CartService>()
                                                .getCartItemById(
                                                    widget.product.id)!
                                                .quantity
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          widget.onRemoveFromCart();
                                        },
                                        child: SizedBox(
                                          height: 5.h,
                                          width: 5.h,
                                          child: Card(
                                            child: Icon(
                                              Icons.remove,
                                              color: AppColors.primary,
                                              size: 5.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                          : widget.amount != null
                              ? const SizedBox.shrink()
                              : PositionedDirectional(
                                  bottom: 0,
                                  start: 0,
                                  child: InkWell(
                                    onTap: () {
                                      widget.onAddToCart();
                                    },
                                    child: SizedBox(
                                      height: 5.h,
                                      width: 5.h,
                                      child: Card(
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.primary,
                                          size: 5.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                  ],
                ),
              ),
            ),
            Gap(1.h),
            Row(
              children: [
                Text(
                  context.locale == const Locale('ar')
                      ? "${widget.product.price.toStringAsFixed(3)} د.ك"
                      : "${widget.product.price.toStringAsFixed(3)} K.D",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Gap(1.w),
                if (widget.product.oldPrice > widget.product.price)
                  Text(
                    context.locale == const Locale('ar')
                        ? "${widget.product.oldPrice.toStringAsFixed(3)} د.ك"
                        : "${widget.product.oldPrice.toStringAsFixed(3)} K.D",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            widget.amount == null
                ? Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.hintColor,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.cart_quantity.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.lightTextColor,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        '(${widget.amount})',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
