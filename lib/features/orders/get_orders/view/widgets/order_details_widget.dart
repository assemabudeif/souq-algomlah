import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/features/home/widgets/home_product_item_widget.dart';
import '/features/orders/model/order_details_response.dart';
import '/generated/locale_keys.g.dart';

class OrderDetailsWidget extends StatefulWidget {
  const OrderDetailsWidget({
    super.key,
    required this.orders,
  });

  final OrderDetailsResponse orders;

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${LocaleKeys.payment_order_details_status.tr()}: ',
              style: getMediumStyle,
            ),
            Text(
              ' ${widget.orders.state!}',
              style: getSemiBoldStyle,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${context.locale == const Locale("ar") ? "تاريخ الطلب" : "Order Date"}: ',
              style: getMediumStyle,
            ),
            Text(
              DateFormat('yyyy-MM-dd HH:mm').format(
                DateTime.parse(
                  widget.orders.createdAt!,
                ),
              ),
              style: getSemiBoldStyle,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${LocaleKeys.payment_order_details_mobile.tr()}: ',
              style: getMediumStyle,
            ),
            Text(
              ' ${widget.orders.phone!}',
              style: getSemiBoldStyle,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${LocaleKeys.payment_order_details_subtotal.tr()}: ',
              style: getMediumStyle,
            ),
            Text(
              ' ${widget.orders.productsPrice!} ${context.locale == const Locale('ar') ? "د.ك" : "K.D"}',
              style: getSemiBoldStyle,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${LocaleKeys.payment_order_details_total.tr()}: ',
              style: getMediumStyle,
            ),
            Text(
              ' ${widget.orders.totalCost!}  ${context.locale == const Locale('ar') ? "د.ك" : "K.D"}',
              style: getSemiBoldStyle,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Text(
              '${LocaleKeys.my_account_list_cart.tr()}: ',
              style: getSemiBoldStyle,
            ),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          padding: EdgeInsets.all(1.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.5),
            ),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.orders.cart!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.w,
              mainAxisSpacing: 1.h,
              childAspectRatio: 0.8,
              // mainAxisExtent: 10.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  //TODO: Add Category ID
                  HomeProductItemWidget(
                      emitState: () {
                        setState(() {});
                      },
                      product: widget.orders.cart![index].product!,
                      amount: widget.orders.cart![index].amount!,
                      onAddToCart: () {},
                      onRemoveFromCart: () {}),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
