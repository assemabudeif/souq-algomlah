import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/data/models/cities_model.dart';
import '/features/cart/views/payment_screen.dart';
import '/features/orders/model/post_order_request.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/cart/models/cart_item_model.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/core/utilities/font_manager.dart';
import '/features/cart/viewmodel/cart_cubit.dart';
import '/features/home/widgets/home_appbar_title.dart';
import '/generated/assets.dart';
import '/generated/locale_keys.g.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int cartMethod = 0;
  final _vm = sl<CartCubit>();

  @override
  void initState() {
    _vm.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) => didPop,
      child: Scaffold(
        appBar: AppBar(
          title: homeAppBarTitle(context),
          actions: [
            InkWell(
              onTap: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          context.locale == const Locale('en')
                              ? 'Delete All Cart'
                              : 'حذف كل السلة',
                        ),
                        content: Text(
                          context.locale == const Locale('en')
                              ? 'Are you sure you want to delete all cart items?'
                              : 'هل أنت متأكد أنك تريد حذف جميع عناصر السلة',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              LocaleKeys.general_cancel.tr(),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              sl<CartService>().dropCart();
                              setState(() {});
                              context.navigateToNamedWithPopUntil(
                                AppRoutes.homeRoute,
                              );
                            },
                            child: Text(
                              LocaleKeys.my_account_delete.tr(),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: SvgPicture.asset(
                Assets.assetsSvgsDelete,
                height: 3.5.h,
                colorFilter: const ColorFilter.mode(
                  AppColors.dangerColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Gap(5.w),
          ],
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: BlocProvider<CartCubit>(
          create: (context) => _vm,
          child: BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (_vm.cartItems == null && _vm.cartItemsError.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (_vm.cartItems?.isEmpty ?? false) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.assetsSvgsCart,
                        height: 20.h,
                      ),
                      Gap(2.h),
                      Text(
                        context.locale == const Locale('en')
                            ? 'Your cart is empty'
                            : 'سلتك فارغة',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (_vm.cartItemsError.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.assetsSvgsInfo,
                        height: 20.h,
                        colorFilter: const ColorFilter.mode(
                          AppColors.dangerColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        context.locale == const Locale('en')
                            ? 'An error occurred'
                            : 'حدث خطأ',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (_vm.cartItems != null && _vm.cartItems!.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () {
                    return _vm.reload();
                  },
                  child: SizedBox(
                    height: 100.h,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            itemCount: _vm.cartItems!.length,
                            separatorBuilder: (context, index) {
                              return Gap(2.5.h);
                            },
                            itemBuilder: (context, index) {
                              return cartItemWidget(
                                _vm.cartItems!,
                                index,
                                context,
                              );
                            },
                          ),
                          Gap(3.h),

                          // Shipping Address
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              context.locale == const Locale('en')
                                  ? 'Shipping Address'
                                  : 'عنوان الشحن',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          Gap(2.h),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 2.h,
                            ),
                            child: Form(
                              key: _vm.formKey,
                              child: Column(
                                children: [
                                  DropdownSearch<CityModel>(
                                    selectedItem: _vm.selectedCity,
                                    onChanged: (value) {
                                      _vm.selectedCity = value;
                                      setState(() {});
                                    },
                                    dropdownButtonProps: DropdownButtonProps(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.blackWithOpacityColor,
                                      ),
                                      iconSize: 5.w,
                                    ),
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      baseStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight:
                                            FontManager.mediumFontWeight,
                                        color: AppColors.blackColor,
                                      ),
                                      textAlign: TextAlign.start,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: LocaleKeys
                                            .home_city_dialog_choose_city
                                            .tr(),
                                        hintStyle: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                          color: AppColors.lightTextColor,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 2.h,
                                        ),
                                        border: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.borderColor,
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.borderColor,
                                          ),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.borderColor,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor:
                                            AppColors.secondBackgroundColor,
                                      ),
                                    ),
                                    items: _vm.cities,
                                    autoValidateMode: AutovalidateMode.always,
                                    enabled: true,
                                    compareFn: (item, selectedItem) =>
                                        item == selectedItem,
                                    itemAsString: (item) =>
                                        context.locale == const Locale("ar")
                                            ? item.name
                                            : item.englishName,
                                    popupProps: PopupProps.dialog(
                                      showSearchBox: true,
                                      fit: FlexFit.tight,
                                      containerBuilder: (context, popupWidget) {
                                        return Material(
                                          child: Container(
                                            width: 100.w,
                                            height: 100.h,
                                            color: AppColors.whiteColor,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 3.h,
                                            ),
                                            child: popupWidget,
                                          ),
                                        );
                                      },
                                      title: Text(
                                        LocaleKeys.home_city_dialog_choose_city
                                            .tr(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                          color: AppColors.lightTextColor,
                                        ),
                                      ),
                                      dialogProps: DialogProps(
                                        backgroundColor: AppColors.whiteColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.w),
                                        ),
                                        useRootNavigator: true,
                                      ),
                                    ),
                                  ),
                                  Gap(1.h),
                                  TextFormField(
                                    controller: _vm.phoneController,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9+]+')),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: LocaleKeys.auth_mobile.tr(),
                                    ),
                                    validator: (value) {
                                      var regex = RegExp(r'^[569]\d{7}$');
                                      if (value == null || value.isEmpty) {
                                        return LocaleKeys.general_required_field
                                            .tr();
                                      } else if (regex.hasMatch(value) ==
                                          false) {
                                        return context.locale ==
                                                const Locale("en")
                                            ? "Invalid Phone number"
                                            : "رقم الهاتف غير صحيح";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  Gap(1.h),
                                  TextFormField(
                                    controller: _vm.regionController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText:
                                          context.locale == const Locale('en')
                                              ? "Region"
                                              : "المنطقة",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LocaleKeys.general_required_field
                                            .tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  Gap(1.h),
                                  TextFormField(
                                    controller: _vm.gadeController,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: InputDecoration(
                                      hintText:
                                          "${LocaleKeys.auth_gada.tr()} ${LocaleKeys.general_optional.tr()}",
                                    ),
                                  ),
                                  Gap(1.h),
                                  TextFormField(
                                    controller: _vm.streetController,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: InputDecoration(
                                      hintText: LocaleKeys.auth_street.tr(),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LocaleKeys.general_required_field
                                            .tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  Gap(1.h),
                                  TextFormField(
                                    controller: _vm.houseNoController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                      hintText: LocaleKeys.auth_house_no.tr(),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LocaleKeys.general_required_field
                                            .tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  Gap(1.h),
                                  Gap(1.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _vm.floorController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          decoration: InputDecoration(
                                            hintText:
                                                LocaleKeys.addresses_floor.tr(),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return LocaleKeys
                                                  .general_required_field
                                                  .tr();
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Gap(1.w),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _vm.apartmentNoController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          decoration: InputDecoration(
                                            hintText: LocaleKeys
                                                .addresses_apartment_number
                                                .tr(),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return LocaleKeys
                                                  .general_required_field
                                                  .tr();
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(3.h),
                          // Payment Method
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              LocaleKeys.payment_order_details_payment_method
                                  .tr(),
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Gap(2.h),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 2.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadioListTile.adaptive(
                                  value: 0,
                                  title: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.assetsSvgsCash,
                                        width: 7.w,
                                      ),
                                      Gap(4.w),
                                      Text(
                                        context.locale == const Locale('en')
                                            ? 'Cash on delivery'
                                            : 'الدفع عند الاستلام',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  groupValue: cartMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      cartMethod = value as int;
                                    });
                                  },
                                ),
                                const Divider(),
                                RadioListTile.adaptive(
                                  value: 1,
                                  title: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.assetsSvgsKnet,
                                        width: 7.w,
                                      ),
                                      Gap(4.w),
                                      Expanded(
                                        child: Text(
                                          context.locale == const Locale('en')
                                              ? 'KNET Online Payment (Online)'
                                              : 'الدفع الإلكتروني عبر KNET (عبر الإنترنت)',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  groupValue: cartMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      cartMethod = value as int;
                                    });
                                  },
                                ),
                                Gap(2.h),
                              ],
                            ),
                          ),
                          Gap(3.h),

                          // Cart Summary
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 2.h,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocaleKeys
                                          .payment_order_details_order_summary
                                          .tr(),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Container(
                                      height: 5.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.primary.withOpacity(0.4),
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${sl<CartService>().getCartItemsCount()} ${LocaleKeys.general_product.tr()}",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocaleKeys.cart_subtotal.tr(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontManager.lightFontWeight,
                                      ),
                                    ),
                                    Text(
                                      "${sl<CartService>().getCartTotalPrice().toStringAsFixed(3)} ${context.locale == const Locale('en') ? 'K.D' : 'د.ك'}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocaleKeys.cart_shipping_cost.tr(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontManager.lightFontWeight,
                                      ),
                                    ),
                                    Text(
                                      "${_vm.selectedCity?.shippingCost.toStringAsFixed(3) ?? "0.000"} ${context.locale == const Locale('en') ? 'K.D' : 'د.ك'}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocaleKeys.cart_total.tr(),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      "${(sl<CartService>().getCartTotalPrice() + (_vm.selectedCity?.shippingCost ?? 0)).toStringAsFixed(3)} ${context.locale == const Locale('en') ? 'K.D' : 'د.ك'}",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Checkout button
                          Gap(2.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            child: BlocConsumer<CartCubit, CartState>(
                              bloc: _vm,
                              listener: (context, state) async {
                                if (state is PostOrderSuccess) {
                                  context.showSuccessSnackBar(
                                    context.locale == const Locale('ar')
                                        ? 'تم انشاء الطلب بنجاح'
                                        : 'Your order has been created successfully',
                                  );
                                  if (state.url != null) {
                                    final totalPrice =
                                        sl<CartService>().getCartTotalPrice();
                                    sl<CartService>().dropCart().then((value) {
                                      log(
                                        totalPrice.toString(),
                                        name: 'Cart Total Price',
                                      );
                                      context.navigateTo(
                                        PaymentScreen(
                                          url: state.url!,
                                          totalPrice: totalPrice,
                                        ),
                                      );
                                    });
                                  } else {
                                    sl<CartService>().dropCart().then((value) {
                                      context.navigateToNamedWithPopUntil(
                                        AppRoutes.homeRoute,
                                      );
                                    });
                                  }
                                }
                                if (state is PostOrderError) {
                                  context.showErrorSnackBar(
                                    state.errorMsg,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return state is PostOrderLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButton(
                                        onPressed: () async {
                                          if (_vm.selectedCity == null) {
                                            context.showErrorSnackBar(
                                              LocaleKeys
                                                  .home_city_dialog_choose_city
                                                  .tr(),
                                            );
                                          } else if (_vm.formKey.currentState!
                                              .validate()) {
                                            log(_vm.selectedCity.toString());
                                            _vm.postOrder(
                                              context: context,
                                              req: PostOrderRequest(
                                                phone: _vm.phoneController.text,
                                                address: Address(
                                                  city: _vm.selectedCity!.name,
                                                  governorate:
                                                      _vm.regionController.text,
                                                  street:
                                                      _vm.streetController.text,
                                                  homeNumber: _vm
                                                      .houseNoController.text,
                                                  floorNumber:
                                                      _vm.floorController.text,
                                                  flatNumber: _vm
                                                      .apartmentNoController
                                                      .text,
                                                  description:
                                                      _vm.gadeController.text,
                                                ),
                                                cart: sl<CartService>()
                                                    .getCartItems()
                                                    .map(
                                                      (element) => Cart(
                                                        product:
                                                            element.product.id,
                                                        amount:
                                                            element.quantity,
                                                      ),
                                                    )
                                                    .toList(),
                                                onlinePay: cartMethod == 1
                                                    ? true
                                                    : false,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          LocaleKeys.cart_checkout.tr(),
                                        ),
                                      );
                              },
                            ),
                          ),
                          Gap(5.h),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Container cartItemWidget(
    List<CartItemModel> data,
    int index,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(
            data[index].product.firstImage,
            width: 20.w,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index].product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${LocaleKeys.cart_price.tr()}: ${data[index].product.price.toStringAsFixed(3)}",
                          ),
                          Text(
                            "${LocaleKeys.cart_total_product_price.tr()}: ${(data[index].product.price * data[index].quantity).toStringAsFixed(3)}",
                            style: const TextStyle(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.w,
                            vertical: 1.5.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    sl<CartService>().increaseQuantity(
                                      context: context,
                                      id: data[index].id,
                                      purchaseLimit:
                                          data[index].product.purchaseLimit,
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 5.w,
                                ),
                              ),
                              Text(
                                data[index].quantity.toString(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                              if (data[index].quantity > 1)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      sl<CartService>().decreaseQuantity(
                                        data[index].id,
                                      );
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    size: 5.w,
                                  ),
                                )
                              else
                                InkWell(
                                  onTap: () {
                                    _vm.deleteCartItem(
                                      data[index].id,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    Assets.assetsSvgsDelete,
                                    height: 5.w,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.dangerColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
