import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/features/orders/model/get_all_orders_response.dart';
import '/generated/locale_keys.g.dart';

class AllOrdersList extends StatelessWidget {
  const AllOrdersList({
    super.key,
    required this.orders,
  });

  final List<GetAllOrdersResponse> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          context.locale == const Locale('ar') ? 'لا يوجد طلبات' : 'No Orders',
          style: getSemiBoldStyle.copyWith(
            fontSize: 20.sp,
            color: AppColors.primary,
          ),
        ),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 0.8.h,
          ),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: AppColors.greyColor,
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(12.sp),
            color: AppColors.whiteColor,
            border: Border.all(
              color: AppColors.primary,
              width: 5.sp,
            ),
          ),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       width: 30.w,
              //       child: Text(
              //         orders[index].state.toString(),
              //         style: getSemiBoldStyle,
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //     ),
              //     SizedBox(
              //       width: 25.w,
              //       child: Text(
              //         '${orders[index].createdAt!.day}/${orders[index].createdAt!.month}/${orders[index].createdAt!.year}',
              //         style: getMediumStyle.copyWith(fontSize: 18.sp),
              //       ),
              //     ),
              //     Text.rich(
              //       TextSpan(
              //         children: [
              //           TextSpan(
              //               text: '${orders[index].totalCost} ',
              //               style: getSemiBoldStyle),
              //           TextSpan(
              //               text:
              //                   ' ${context.locale == const Locale('ar') ? 'د.ك' : 'K.D'} ',
              //               style: getMediumStyle.copyWith(fontSize: 15.sp)),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 1.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       width: 35.w,
              //       child: Text(
              //         orders[index].address!.city!,
              //         style: getSemiBoldStyle,
              //       ),
              //     ),
              //     SizedBox(
              //       width: 25.w,
              //       child: Text(
              //         orders[index].address!.governorate!,
              //         textAlign: TextAlign.center,
              //         style: getMediumStyle.copyWith(fontSize: 17.sp),
              //       ),
              //     ),
              //     const Spacer(),
              //     Text(
              //       orders[index].address!.street!,
              //       style: getRegularStyle.copyWith(
              //         fontSize: 15.sp,
              //       ),
              //     ),
              //   ],
              // ),

              //   add modern ui for orders list item
              //   add modern ui for orders list item
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${LocaleKeys.payment_order_details_status.tr()}: ',
                        style: getMediumStyle,
                      ),
                      Text(
                        ' ${orders[index].state!}',
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
                          orders[index].createdAt!,
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
                        ' ${orders[index].phone!}',
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
                        ' ${orders[index].totalCost!}  ${context.locale == const Locale('ar') ? "د.ك" : "K.D"}',
                        style: getSemiBoldStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.navigateToNamedWithArguments(
                        AppRoutes.orderDetailsScreen,
                        [
                          orders[index].id!,
                          (orders[index].state! == 'انتظار' ? false : true)
                        ],
                      );
                    },
                    child: Text(
                      context.locale == const Locale('ar')
                          ? 'عرض الطلب'
                          : 'View Order',
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  )
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 3.h),
      itemCount: orders.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
    );
  }
}
