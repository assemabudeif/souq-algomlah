import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/features/home/viewmodel/cubit/home_cubit.dart';
import '/core/data/models/product_model.dart';
import '/core/data/models/sub_category_model.dart';

import 'home_product_item_widget.dart';

class HomeProductsListWidget extends StatefulWidget {
  const HomeProductsListWidget({
    super.key,
    required this.supCategories,
    required this.vm,
  });

  final List<SubCategoryModel> supCategories;
  final HomeCubit vm;

  @override
  State<HomeProductsListWidget> createState() => _HomeProductsListWidgetState();
}

class _HomeProductsListWidgetState extends State<HomeProductsListWidget> {
  List<ProductModel> getProducts() {
    List<ProductModel> products = [];
    for (var element in widget.supCategories) {
      for (var product in element.products) {
        if (product.isAvailable) {
          products.add(product);
        }
      }
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    log(getProducts().length.toString(), name: "Products");
    return SizedBox(
      height: 30.h,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: getProducts().length,
        itemBuilder: (context, index) {
          return HomeProductItemWidget(
            emitState: () {
              widget.vm.emitState();
            },
            product: getProducts()[index],
            onAddToCart: () {
              widget.vm.addToCart(
                categoryId: widget.supCategories[index].id,
                context: context,
                product: getProducts()[index],
              );
            },
            onRemoveFromCart: () {
              widget.vm.removeFromCart(
                context: context,
                productId: getProducts()[index].id,
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return Gap(3.w);
        },
      ),
    );
  }
}
