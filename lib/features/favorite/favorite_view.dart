import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/cart/models/cart_item_model.dart';
import '/core/services/favorite/models/hive_product_model.dart';
import '/core/utilities/extensions.dart';
import '/core/data/models/image_model.dart';
import '/core/data/models/product_model.dart';
import '/core/services/favorite/favorite_service.dart';
import '/core/services/favorite/models/favorite_model.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';

import '/features/home/widgets/home_product_item_widget.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // context.navigateToNamedWithPopUntil(
        //   AppRoutes.homeRoute,
        // );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.locale == const Locale('ar')
                ? 'المنتاجات مفضلة'
                : 'Favorite Products',
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 3.h,
          ),
          child: FutureBuilder<List<FavoriteModel>>(
            future: Future.value(sl<FavoriteService>().getFavorites()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'ErrorL ${snapshot.error}',
                    ),
                  );
                } else {
                  final List<FavoriteModel> products = snapshot.data!;

                  if (products.isEmpty) {
                    return Center(
                      child: Text(
                        context.locale == const Locale('ar')
                            ? 'لا يوجد منتجات مفضلة'
                            : 'No favorite products',
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.aspectRatio * 1.5,
                        crossAxisSpacing: 2.w,
                        mainAxisSpacing: 2.w,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            HomeProductItemWidget(
                              // categoryId:
                              //     products[index].product.categoryId ?? "",
                              emitState: () {
                                setState(() {});
                              },
                              isFavoriteScreen: true,
                              onRemoveFromCart: () {
                                removeFromCart(
                                  context: context,
                                  productId: products[index].id,
                                );
                              },
                              onAddToCart: () {
                                addToCart(
                                  // categoryId:
                                  //     products[index].product.categoryId ?? "",
                                  context: context,
                                  product: ProductModel(
                                    purchaseLimit:
                                        products[index].product.purchaseLimit,
                                    firstImage: ImageModel(
                                      url: products[index].product.firstImage,
                                      publicId: '',
                                    ),
                                    secondImage: ImageModel(
                                      url: products[index].product.secondImage,
                                      publicId: '',
                                    ),
                                    id: products[index].id,
                                    name: context.locale == const Locale('ar')
                                        ? products[index].product.name
                                        : products[index].product.englishName,
                                    arName: products[index].product.name,
                                    enName: products[index].product.englishName,
                                    desc: products[index].product.desc,
                                    price: products[index].product.price,
                                    isAvailable:
                                        products[index].product.isAvailable,
                                    amount: products[index].product.amount,
                                    oldPrice: products[index].product.oldPrice,
                                    createdAt:
                                        products[index].product.createdAt,
                                    updatedAt:
                                        products[index].product.updatedAt,
                                    v: products[index].product.v,
                                  ),
                                );
                              },
                              product: ProductModel(
                                purchaseLimit:
                                    products[index].product.purchaseLimit,
                                firstImage: ImageModel(
                                  url: products[index].product.firstImage,
                                  publicId: '',
                                ),
                                secondImage: ImageModel(
                                  url: products[index].product.secondImage,
                                  publicId: '',
                                ),
                                id: products[index].id,
                                name: context.locale == const Locale('ar')
                                    ? products[index].product.name
                                    : products[index].product.englishName,
                                arName: products[index].product.name,
                                enName: products[index].product.englishName,
                                desc: products[index].product.desc,
                                price: products[index].product.price,
                                isAvailable:
                                    products[index].product.isAvailable,
                                amount: products[index].product.amount,
                                oldPrice: products[index].product.oldPrice,
                                createdAt: products[index].product.createdAt,
                                updatedAt: products[index].product.updatedAt,
                                v: products[index].product.v,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  sl<FavoriteService>().removeFavorite(
                                    products[index].id,
                                  );
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.whiteColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.greyColor,
                                        blurRadius: 2,
                                        spreadRadius: 0.1,
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(1.w),
                                  child: Icon(
                                    Icons.delete,
                                    size: 22.sp,
                                    color: AppColors.dangerColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> addToCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    if (!sl<CartService>().isItemInCart(product.id)) {
      final hiveProduct = HiveProductModel(
        // categoryId: categoryId,
        id: product.id,
        amount: product.amount,
        createdAt: product.createdAt,
        desc: product.desc,
        englishName: product.enName,
        name: product.name,
        firstImage: product.firstImage.url,
        secondImage: product.secondImage.url,
        isAvailable: product.isAvailable,
        oldPrice: product.oldPrice,
        price: product.price,
        updatedAt: product.updatedAt,
        v: product.v,
        purchaseLimit: product.purchaseLimit,
      );
      if (product.amount > 5) {
        setState(() {
          sl<CartService>().addCartItem(
            CartItemModel(
              id: product.id,
              product: hiveProduct,
            ),
          );
        });

        context.showSuccessSnackBar(
          context.locale == const Locale('ar')
              ? 'تمت اضافة المنتج إلى السلة بنجاح'
              : 'Product Added to Cart Successfully',
        );
      } else {
        context.showWarningSnackBar(
          context.locale == const Locale('ar')
              ? 'المنتج غير متوفر حاليا'
              : 'Product not available now',
        );
      }
    } else {
      context.showWarningSnackBar(
        context.locale == const Locale('ar')
            ? 'المنتج موجود في السلة'
            : 'Product already added to cart',
      );
    }
  }

  Future<void> removeFromCart({
    required BuildContext context,
    required String productId,
  }) async {
    if (sl<CartService>().isItemInCart(productId)) {
      setState(() {
        sl<CartService>().removeCartItem(productId);
      });
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
  }
}
