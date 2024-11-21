
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';

_calculateTotalPriceOfCart() {
  double total = 0;
  for (var cartItem in sl<CartService>().getCartItems()) {
    total += cartItem.product.price * cartItem.quantity;
  }

  return total;
}

showCartButtonWidget({
  required BuildContext context,
  required Function onTap,
}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 10.h,
      width: 100.w,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 2.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.successColor,
          borderRadius: BorderRadius.circular(2.w),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        child: Row(
          children: [
            Container(
              width: 5.w,
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(1.w),
              ),
              alignment: Alignment.center,
              child: Text(
                sl<CartService>().getCartItems().length.toString(),
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Gap(4.w),
            Text(
              context.locale == const Locale('ar') ? 'شاهد السلة' : 'Show Cart',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 17.sp,
              ),
            ),
            const Spacer(),
            Text(
              context.locale == const Locale('ar')
                  ? '${_calculateTotalPriceOfCart().toStringAsFixed(3)} د.ك'
                  : '${_calculateTotalPriceOfCart().toStringAsFixed(3)} K.D',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
