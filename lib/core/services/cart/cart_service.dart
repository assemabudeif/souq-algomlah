import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/core/utilities/extensions.dart';
import '/core/services/cart/models/cart_item_model.dart';

class CartService {
  final Box<CartItemModel> _cartBox = Hive.box<CartItemModel>('cart');

  List<CartItemModel> getCartItems() {
    return _cartBox.values.toList();
  }

  CartItemModel? getCartItemById(String id) {
    return _cartBox.get(id);
  }

  Future<void> addCartItem(CartItemModel cartItem) async {
    await _cartBox.put(cartItem.id, cartItem);
  }

  Future<void> removeCartItem(String id) async {
    await _cartBox.delete(id);
  }

  Future<void> updateCartItem(CartItemModel cartItem) async {
    await _cartBox.put(cartItem.id, cartItem);
  }

  bool isItemInCart(String id) {
    return _cartBox.containsKey(id);
  }

  Future<void> dropCart() async {
    await _cartBox.clear();
  }

  int getCartItemsCount() {
    return _cartBox.length;
  }

  double getCartTotalPrice() {
    double totalPrice = 0;
    for (final item in _cartBox.values) {
      totalPrice += item.product.price * item.quantity;
    }
    return double.parse(totalPrice.toStringAsFixed(2));
  }

  void increaseQuantity({
    required BuildContext context,
    required String id,
    required int purchaseLimit,
  }) {
    final cartItem = _cartBox.get(id);
    // log('cartItem: ${cartItem!.product.amount}');
    if (cartItem != null && cartItem.product.amount > cartItem.quantity) {
      if (purchaseLimit < cartItem.quantity && purchaseLimit != -1) {
        context.showWarningSnackBar(
          context.locale == const Locale('ar')
              ? 'لقد وصلت للحد الأقصى للكمية المتاحة'
              : 'You have reached the maximum quantity available',
        );
      }
      cartItem.quantity++;
      updateCartItem(cartItem);
    } else {
      context.showErrorSnackBar(
        context.locale == const Locale('ar')
            ? 'لقد وصلت للحد الأقصى للكمية المتاحة'
            : 'You have reached the maximum quantity available',
      );
    }
  }

  void decreaseQuantity(String id) {
    final cartItem = _cartBox.get(id);
    if (cartItem != null) {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
        updateCartItem(cartItem);
      }
    }
  }
}
