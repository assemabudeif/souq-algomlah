import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/cart/models/cart_item_model.dart';
import '/core/services/favorite/models/hive_product_model.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/extensions.dart';
import '/core/data/models/product_model.dart';
import '/features/search/model/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchRepo) : super(SearchInitial());

  final SearchRepo _searchRepo;
  final TextEditingController searchController = TextEditingController();

  List<ProductModel> products = [];
  String searchError = '';

  init() async {
    await search();
  }

  Future<void> search() async {
    emit(SearchLoading());
    final text = searchController.text.isEmpty ? " " : searchController.text;
    final result = await _searchRepo.search(searchText: text);
    result.fold(
      (failure) {
        searchError = failure.errMsg;

        emit(SearchError(failure.errMsg));
      },
      (products) {
        this.products = products;
        emit(SearchLoaded(products));
      },
    );
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }

  Future<void> addToCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    emit(AddToCartLoading());
    if (!sl<CartService>().isItemInCart(product.id)) {
      //TODO: Add Category ID

      final hiveProduct = HiveProductModel(
        // categoryId: "",
        purchaseLimit: product.purchaseLimit,
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
    emit(SearchInitial());
    emit(SearchUpdate());
  }
}
