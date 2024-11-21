import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_constance.dart';
import '/core/data/models/cities_model.dart';
import '/core/data/repo/cities_repo.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/features/orders/model/post_order_request.dart';
import '/features/orders/repo/orders_repo.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/cart/models/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(
    this._cartService,
    this._citiesRepo,
    this._ordersRepo,
  ) : super(CartInitial());
  final CartService _cartService;
  final CitiesRepo _citiesRepo;
  final OrdersRepo _ordersRepo;

  final formKey = GlobalKey<FormState>();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController gadeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController apartmentNoController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<CartItemModel>? cartItems;
  String cartItemsError = '';
  CityModel? selectedCity;
  List<CityModel> cities = [];

  num minimumOrderCost = 0;

  Future<void> getCartItems() async {
    emit(GetCartItemsLoading());
    try {
      cartItems = _cartService.getCartItems();
      emit(GetCartItemsSuccess());
    } catch (e) {
      cartItemsError = e.toString();
      emit(GetCartItemsFailed());
    }
  }

  void init(BuildContext context) {
    getMinimumCost();
    getCities(context);
    getCartItems();
  }

  Future<void> reload() async {
    cartItems = null;
    cartItemsError = '';
    await getCartItems();
  }

  void getCities(BuildContext context) async {
    emit(CartGetCitiesLoadingState());
    final cities = await _citiesRepo.getCities();
    cities.fold(
      (failure) {
        this.cities = [];
        context.showErrorSnackBar(failure.errMsg);
        emit(CartGetCitiesErrorState());
      },
      (cities) {
        this.cities = cities;
        emit(CartGetCitiesSuccessState());
      },
    );
  }

  deleteCartItem(String id) {
    sl<CartService>().removeCartItem(id);
    reload();
  }

  dispose() {
    regionController.dispose();
    gadeController.dispose();
    streetController.dispose();
    houseNoController.dispose();
    floorController.dispose();
    apartmentNoController.dispose();
  }

  void checkout(BuildContext context, int cartMethod) {
    if (sl<AppPreferences>().getGustUser()) {
      context.showErrorSnackBar(
        context.locale == const Locale('en')
            ? 'Please login first'
            : 'من فضلك قم بتسجيل الدخول أولاً',
      );
    } else {
      if (formKey.currentState!.validate()) {}
    }
  }

  Future<void> postOrder({
    required PostOrderRequest req,
    required BuildContext context,
  }) async {
    if (minimumOrderCost <= sl<CartService>().getCartTotalPrice()) {
      log('here');
      log('req: ${req.cart[0].product}');
      emit(PostOrderLoading());
      final result = await _ordersRepo.postOrder(req);
      result.fold(
        (error) {
          if ((kAppLanguageCode == "en" && error.errMsg.contains("login")) ||
              (kAppLanguageCode == "ar" && error.errMsg.contains("تسجيل"))) {
            context.showErrorSnackBar(error.errMsg);
            sl<AppPreferences>().setGustUser(true);
            sl<AppPreferences>().removeToken();
            sl<AppPreferences>().removeUserEmail();
            sl<AppPreferences>().removeUserId();
            sl<AppPreferences>().removeUserName();

            kUserName = '';
            kUserId = '';
            ApiConstance.token = '';
            context.navigateToNamedWithPopUntil(AppRoutes.loginRoute);
          }
          emit(PostOrderError(error.errMsg));
        },
        (user) {
          sl<CartService>().dropCart();
          emit(PostOrderSuccess(user.url));
        },
      );
    } else {
      context.showErrorSnackBar(
        context.locale == const Locale('en')
            ? 'Minimum order cost is $minimumOrderCost K.D'
            : 'الحد الادنى للطلب هو $minimumOrderCost د.ك',
      );
    }
  }

  getMinimumCost() async {
    final result = await _ordersRepo.getMinimumOrderCost();
    result.fold(
      (l) {
        minimumOrderCost = 0;
        log(l.errMsg, name: 'Get Minimum Cost Error');
      },
      (r) {
        minimumOrderCost = r;
        log(r.toString(), name: 'Get Minimum Cost Success');
      },
    );
  }
}
