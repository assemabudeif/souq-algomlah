import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/theme/app_color.dart';
import 'package:souqalgomlah_app/core/utilities/font_manager.dart';
import 'package:souqalgomlah_app/generated/assets.dart';
import 'package:souqalgomlah_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CheckVersionView extends StatefulWidget {
  const CheckVersionView({super.key});

  @override
  State<CheckVersionView> createState() => _CheckVersionViewState();
}

class _CheckVersionViewState extends State<CheckVersionView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: CheckVersionHeaderWidget()),
            CheckVersionFooterWidget(),
          ],
        ),
      ),
    );
  }
}

class CheckVersionHeaderWidget extends StatelessWidget {
  const CheckVersionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.assetsImagesLogo,
            height: 15.h,
          ),
          Gap(4.h),
          Text(
            LocaleKeys.general_update.tr(),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontManager.boldFontWeight,
              color: AppColors.primary,
            ),
          ),
          Gap(2.h),
          Text(
            LocaleKeys.general_update_app.tr(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontManager.semiBoldFontWeight,
            ),
          ),
        ],
      ),
    );
  }
}

class CheckVersionFooterWidget extends StatelessWidget {
  const CheckVersionFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 2.h,
      ),
      child: ElevatedButton(
        onPressed: () async {
          final appUrl = Platform.isIOS
              ? "https://apps.apple.com/us/app/souq-algomlah/id6621180810"
              : "https://play.google.com/store/apps/details?id=com.souqalgomlah.app";

          if (await canLaunchUrlString(appUrl)) {
            launchUrlString(appUrl);
          }
        },
        child: Text(
          LocaleKeys.general_update_app_btn.tr(),
        ),
      ),
    );
  }
}
