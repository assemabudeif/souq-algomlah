import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:souqalgomlah_app/core/constants/app_constance.dart';
import 'package:souqalgomlah_app/core/functions/send_fcm.dart';
import 'package:souqalgomlah_app/features/home/model/main_baner_model.dart';
import '/core/data/models/product_model.dart';
import '/core/services/app_prefs.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/cart/models/cart_item_model.dart';
import '/core/services/favorite/models/hive_product_model.dart';
import '/core/services/services_locator.dart';
import '/features/auth/login/model/login_model.dart';
import '/core/functions/logout.dart';
import '/core/data/models/all_categories_model.dart';
import '/features/favorite/favorite_view.dart';
import '/features/home/viewmodel/repo/home_repo.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '../../model/home_drawer_model.dart';
import '/generated/assets.dart';
import '/generated/locale_keys.g.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  AllCategoriesModel? homeData;
  String homeDataError = '';
  List<MainBannerModel> mainBanners = [];
  String mainBannersError = '';

  init(BuildContext context) async {
    if (context.mounted) {
      if (kUserId != "") {
        final res = await sendFCM();
        res.fold(
          (l) => log(l.errMsg, name: 'FCM Error'),
          (r) => log(r, name: 'FCM Success'),
        );
      }
      await getMainBanners();

      await getUserDetails(context);

      await getHomeData(context);
    }
  }

  List<HomeDrawerModel> drawerItems(BuildContext context) => [
        HomeDrawerModel(
          title: LocaleKeys.home_drawer_main.tr(),
          icon: Assets.assetsSvgsHome,
          onTap: () {
            context.pop();
          },
        ),
        HomeDrawerModel(
          title: LocaleKeys.home_drawer_cart.tr(),
          icon: Assets.assetsSvgsCart,
          route: AppRoutes.cartRoute,
        ),
        // const HomeDrawerModel(
        //   title: 'Wallet',
        //   icon: Assets.assetsSvgsWallet,
        //   route: '',
        // ),
        // HomeDrawerModel(
        //   title: LocaleKeys.home_drawer_notifications.tr(),
        //   icon: Assets.assetsSvgsNotification,
        //   route: '',
        // ),
        if (!sl<AppPreferences>().getGustUser())
          HomeDrawerModel(
            title: LocaleKeys.home_drawer_my_orders.tr(),
            icon: Assets.assetsSvgsDelivery,
            route: '',
            onTap: () {
              context.navigateToNamed(AppRoutes.ordersRoute);
            },
          ),
        HomeDrawerModel(
          title: LocaleKeys.home_drawer_my_wish_list.tr(),
          icon: Assets.assetsSvgsWishlist,
          route: '',
          onTap: () {
            context.navigateTo(const FavoriteView());
          },
        ),
        HomeDrawerModel(
          title: LocaleKeys.home_drawer_change_language.tr(),
          icon: Assets.assetsSvgsLanguage,
          route: AppRoutes.changeLanguageRoute,
        ),
        if (!sl<AppPreferences>().getGustUser())
          HomeDrawerModel(
            title: LocaleKeys.my_account_title.tr(),
            icon: Assets.assetsSvgsMyAccount,
            route: AppRoutes.profileRoute,
          ),
        if (sl<AppPreferences>().getGustUser())
          HomeDrawerModel(
            title: LocaleKeys.auth_login.tr(),
            icon: Assets.assetsSvgsMyAccount,
            route: AppRoutes.loginRoute,
          ),
        HomeDrawerModel(
          title: LocaleKeys.home_drawer_contact_us.tr(),
          icon: Assets.assetsSvgsContactUs,
          route: AppRoutes.contactUsRoute,
        ),
        // HomeDrawerModel(
        //   title: LocaleKeys.home_drawer_share_app.tr(),
        //   icon: Assets.assetsSvgsInviteFriends,
        //   route: '',
        // ),
        HomeDrawerModel(
          title: LocaleKeys.home_drawer_policy_privacy.tr(),
          icon: Assets.assetsSvgsInfo,
          route: AppRoutes.privacyPolicyRoute,
        ),
        if (!sl<AppPreferences>().getGustUser())
          HomeDrawerModel(
            title: LocaleKeys.settings_logout.tr(),
            icon: Assets.assetsSvgsLogout,
            route: '',
            onTap: () async {
              logout(context);
            },
          ),
      ];

  void openDrawer() {
    emit(HomeInitial());
    scaffoldKey.currentState!.openDrawer();
    emit(HomeOpenDrawerState());
  }

  Future<void> getHomeData(BuildContext context) async {
    emit(GetHomeDataLoadingDate());
    final response = await _homeRepo.getAllCategories();
    response.fold(
      (l) {
        homeDataError = l.errMsg;
        emit(GetHomeDataErrorDate());
      },
      (r) {
        homeData = r;
        emit(GetHomeDataSuccessDate());
      },
    );
  }

  Future<void> addToCart({
    required BuildContext context,
    required ProductModel product,
    required String categoryId,
  }) async {
    emit(AddToCartLoading());
    if (!sl<CartService>().isItemInCart(product.id)) {
      final hiveProduct = HiveProductModel(
        // categoryId: categoryId,
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

  Future<void> getUserDetails(BuildContext context) async {
    if (!sl<AppPreferences>().getGustUser()) {
      emit(GetUserDetailsLoading());
      final response = await _homeRepo.getUserDetails();
      response.fold(
        (l) {
          context.showErrorSnackBar(l.errMsg);
          emit(GetUserDetailsError());
        },
        (r) {
          LoginModel loginModel = sl<AppPreferences>().getLoginModel();
          sl<AppPreferences>().setLoginModel(
            loginModel.copyWith(
              username: r.name,
              points: r.points,
              wallet: r.wallet,
              id: r.id,
              address: loginModel.address.copyWith(
                city: r.address.city,
                cityEnglish: "",
                governorate: r.address.governorate,
                street: r.address.street,
                homeNumber: r.address.homeNumber,
                floorNumber: r.address.floorNumber,
                flatNumber: r.address.flatNumber,
                description: "",
              ),
            ),
          );
          emit(GetUserDetailsSuccess());
        },
      );
    }
  }

  Future<void> getMainBanners() async {
    emit(GetMainBannersLoading());
    final response = await _homeRepo.getMainBanners();
    response.fold(
      (l) {
        homeDataError = l.errMsg;
        log(l.errMsg);
        emit(GetMainBannersError());
      },
      (r) {
        mainBanners = r;
        emit(GetMainBannersSuccess());
      },
    );
  }

  void emitState() {
    emit(HomeInitial());
    emit(HomeUpdate());
  }
}
