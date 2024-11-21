import 'package:avatar_glow/avatar_glow.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/theme/app_color.dart';
import 'package:souqalgomlah_app/core/utilities/font_manager.dart';
import 'package:souqalgomlah_app/generated/locale_keys.g.dart';

class CheckInternetConnectionView extends StatefulWidget {
  const CheckInternetConnectionView({super.key, required this.child});
  final Widget child;

  @override
  State<CheckInternetConnectionView> createState() =>
      _CheckInternetConnectionViewState();
}

class _CheckInternetConnectionViewState
    extends State<CheckInternetConnectionView> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
      _connectionStatus = result.first;
    } on PlatformException {
      _connectionStatus = ConnectivityResult.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _connectionStatus = snapshot.data!.first;
            if (_connectionStatus == ConnectivityResult.none) {
              return Scaffold(
                body: Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AvatarGlow(
                        animate: true,
                        // glowRadiusFactor: 50.w,
                        curve: Curves.decelerate,
                        duration: const Duration(milliseconds: 1500),
                        glowCount: 2,
                        glowColor: AppColors.primary,
                        child: Icon(
                          Icons.cloud_off_rounded,
                          color: AppColors.primary,
                          size: 20.w,
                        ),
                      ),
                      Gap(10.h),
                      Text(
                        LocaleKeys.general_check_internet_connection.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontManager.semiBoldFontWeight,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return widget.child;
        });
  }
}
