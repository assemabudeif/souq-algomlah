import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/global/widgets/check_connectivity.dart';
import '/core/constants/app_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/generated/locale_keys.g.dart';

import '../viewmodel/get_all_orders/get_orders_cubit.dart';
import 'widgets/all_orders_list.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  _bind() async {
    await BlocProvider.of<GetAllOrdersCubit>(context).getAllOrders();
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
        title: Text(
          LocaleKeys.home_drawer_my_orders.tr(),
        ),
        centerTitle: true,
      ),
      body: CheckInternetConnectionView(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 2.h,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
                  builder: (context, state) {
                    if (state is GetAllOrdersSuccess) {
                      return AllOrdersList(
                        orders: state.orders,
                      );
                    }

                    if (state is GetAllOrdersError) {
                      return Center(
                        child: Column(
                          children: [
                            Text(
                              state.errorMsg,
                            ),
                            if ((kAppLanguageCode == "en" &&
                                    !state.errorMsg.contains("login")) ||
                                (kAppLanguageCode == "ar" &&
                                    !state.errorMsg.contains("تسجيل")))
                              TextButton(
                                onPressed: () {
                                  _bind();
                                },
                                child: Text(
                                  LocaleKeys.reset_password_retry.tr(),
                                ),
                              ),
                            if ((kAppLanguageCode == "en" &&
                                    state.errorMsg.contains("login")) ||
                                (kAppLanguageCode == "ar" &&
                                    state.errorMsg.contains("تسجيل")))
                              TextButton(
                                onPressed: () {
                                  sl<AppPreferences>().clear();
                                  context.navigateToNamedWithPopUntil(
                                    AppRoutes.loginRoute,
                                  );
                                },
                                child: Text(
                                  LocaleKeys.auth_login.tr(),
                                ),
                              ),
                          ],
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
    );
  }
}
