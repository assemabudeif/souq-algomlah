import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/cart/models/cart_item_model.dart';
import '/core/services/favorite/models/hive_product_model.dart';
import '/core/services/services_locator.dart';
import '/core/data/models/category_model.dart';
import '/core/data/models/product_model.dart';
import '/core/utilities/extensions.dart';
import '/features/category_details/model/category_details_repo.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit(this._categoryDetailsRepo)
      : super(CategoryDetailsInitial());

  final CategoryDetailsRepo _categoryDetailsRepo;

  CategoryModel? categoryModel;
  String categoryError = '';
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int currentPage = 0;

  changePage({
    required BuildContext context,
    required int index,
  }) {
    emit(CategoryDetailsInitial());
    currentPage = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    if ((index) == categoryModel!.subCategories.length) {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    } else {
      scrollController.jumpTo(
        index.toDouble(),
      );
    }
    emit(ChangePageIndexState());
  }

  Future<void> init({
    required BuildContext context,
    required String categoryId,
  }) async {
    emit(CategoryDetailsInitial());
    try {
      await getCategoryDetails(
        categoryId: categoryId,
        context: context,
      );
    } catch (e) {
      emit(CategoryDetailsError(e.toString()));
    }
  }

  Future<void> getCategoryDetails({
    required BuildContext context,
    required String categoryId,
  }) async {
    emit(GetCategoryDetailsLoadingState());
    final categoryDetails = await _categoryDetailsRepo.getCategoryDetails(
      categoryId: categoryId,
    );
    categoryDetails.fold(
      (failure) {
        categoryError = failure.toString();
        context.showErrorSnackBar(failure.errMsg);
        emit(GetCategoryDetailsErrorState());
      },
      (categoryModel) {
        this.categoryModel = categoryModel;
        emit(GetCategoryDetailsSuccessState());
      },
    );
  }

  List<ProductModel> getAllProduct() {
    List<ProductModel> products = [];
    if (categoryModel != null) {
      for (var subCategories in categoryModel!.subCategories) {
        products.addAll(subCategories.products);
      }
    }

    return products;
  }

  @override
  Future<void> close() {
    pageController.dispose();
    scrollController.dispose();
    return super.close();
  }

  Future<void> addToCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    emit(AddToCartLoading());
    if (!sl<CartService>().isItemInCart(product.id)) {
      final hiveProduct = HiveProductModel(
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
        purchaseLimit: product.purchaseLimit,
        // categoryId: categoryId,
        v: product.v,
      );
      if (product.amount > 5) {
        sl<CartService>().addCartItem(
          CartItemModel(
            id: product.id,
            product: hiveProduct,
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
              ? 'المنتج غير متوفر حاليا'
              : 'Product not available now',
        );
      }
      emit(AddToCartSuccess());
    } else {
      context.showWarningSnackBar(
        context.locale == const Locale('ar')
            ? 'المنتج موجود في السلة'
            : 'Product already added to cart',
      );
      emit(AddToCartError());
    }
  }

  Future<void> removeFromCart({
    required BuildContext context,
    required String productId,
  }) async {
    emit(RemoveFromCartLoading());
    if (sl<CartService>().isItemInCart(productId)) {
      sl<CartService>().removeCartItem(productId);
      context.showSuccessSnackBar(
        context.locale == const Locale('ar')
            ? 'تمت ازالة المنتج من السلة بنجاح'
            : 'Product Removed from Cart Successfully',
      );
      emit(RemoveFromCartSuccess());
    } else {
      context.showWarningSnackBar(
        context.locale == const Locale('ar')
            ? 'المنتج غير موجود في السلة'
            : 'Product not found in cart',
      );
      emit(RemoveFromCartError());
    }
  }

  void emitState() {
    emit(CategoryDetailsInitial());
    emit(CategoryDetailsUpdate());
  }
}
