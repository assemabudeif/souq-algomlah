// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/global/widgets/check_connectivity.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/extensions.dart';
import '/features/cart/views/payment_screen.dart';

import '/features/orders/get_orders/viewmodel/get_order_details/get_order_details_cubit.dart';
import '/generated/locale_keys.g.dart';

import 'widgets/order_details_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.isPaided,
  });

  final String orderId;
  final bool isPaided;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double totalPrice = 0;

  _bind() async {
    await BlocProvider.of<GetOrderDetailsCubit>(context).getOrderDetails(
      orderId: widget.orderId,
      userId: sl<AppPreferences>().getUserId().toString(),
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          widget.isPaided
              ? const SizedBox()
              : BlocBuilder<GetOrderDetailsCubit, GetOrderDetailsState>(
                  builder: (context, state) {
                    return BlocProvider.of<GetOrderDetailsCubit>(context)
                                .totalPrice !=
                            null
                        ? TextButton(
                            onPressed: () {
                              context.navigateTo(
                                PaymentScreen(
                                  url:
                                      'https://payment.souqalgomlah.com/payment/checkout/${widget.orderId}',
                                  totalPrice:
                                      BlocProvider.of<GetOrderDetailsCubit>(
                                                  context)
                                              .totalPrice ??
                                          0,
                                ),
                              );
                            },
                            child: Text(
                              LocaleKeys.payment_title.tr(),
                            ),
                          )
                        : const SizedBox();
                  },
                )
        ],
        title: Text(
          LocaleKeys.orders_title.tr(),
        ),
        centerTitle: true,
      ),
      body: CheckInternetConnectionView(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 2.h,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  BlocBuilder<GetOrderDetailsCubit, GetOrderDetailsState>(
                    builder: (context, state) {
                      if (state is GetOrderDetailsSuccess) {
                        return OrderDetailsWidget(
                          orders: state.order,
                        );
                      }

                      if (state is GetOrderDetailsError) {
                        return Center(
                          child: Text(
                            state.errorMsg,
                          ),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
