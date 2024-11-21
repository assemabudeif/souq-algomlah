import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/functions/check_app_version.dart';
import 'package:souqalgomlah_app/features/check_version/check_version_view.dart';
import '/core/constants/app_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/generated/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 3), () {
      _navigateToNext();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _navigateToNext() async {
    if (await checkAppVersion()) {
      checkAppVersion().then((value) {
        log(value.toString(), name: 'App Version');
      });
      context.navigateTo(const CheckVersionView());
    } else {
      await sl<AppPreferences>().init(context).then((value) {
        if (kUserId.isNotEmpty || sl<AppPreferences>().getGustUser()) {
          context.navigateToNamedWithPopUntil(AppRoutes.homeRoute);
        } else {
          context.navigateToNamedWithPopUntil(AppRoutes.onboardingRoute);
        }
      }).catchError((error) {
        context.showErrorSnackBar(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          Assets.assetsSvgsSplashBackground,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Center(
          child: Image.asset(
            Assets.assetsImagesLogo,
            height: 20.h,
          ),
        ),
      ],
    );
  }
}
