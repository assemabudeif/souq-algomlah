import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/features/category_details/viewmodel/category_details_cubit.dart';
import '/core/data/models/product_model.dart';
import '/features/home/widgets/home_product_item_widget.dart';

class SubCategoryPageItemWidget extends StatelessWidget {
  const SubCategoryPageItemWidget({
    super.key,
    required this.products,
    required this.categoryDetailsCubit,
  });

  final List<ProductModel> products;
  final CategoryDetailsCubit categoryDetailsCubit;

  @override
  Widget build(BuildContext context) {
    log(products.length.toString());
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.aspectRatio * 1.5,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return HomeProductItemWidget(
          emitState: () {
            categoryDetailsCubit.emitState();
          },
          product: products[index],
          onAddToCart: () {
            categoryDetailsCubit.addToCart(
              product: products[index],
              context: context,
            );
          },
          onRemoveFromCart: () {
            categoryDetailsCubit.removeFromCart(
              productId: products[index].id,
              context: context,
            );
          },
        );
      },
    );
  }
}
