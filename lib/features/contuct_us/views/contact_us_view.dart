import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';
import '/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final String _whatsappNumber = "+96551045225";
  final String _email = "contact@souqalgomlah.com";
  final String _hotNumber = "+96551045225";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_drawer_contact_us.tr()),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.w),
            topRight: Radius.circular(5.w),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.borderColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          top: 10.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 3.h,
        ),
        child: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Column(
            children: [
              _contactUsItemWidget(
                icon: FontAwesomeIcons.phone,
                title: _hotNumber,
                onTap: () {
                  launchUrl(Uri.parse("tel://$_hotNumber"));
                },
                iconColor: AppColors.primary,
              ),
              Gap(5.h),
              _contactUsItemWidget(
                icon: FontAwesomeIcons.envelope,
                title: _email,
                onTap: () {
                  launchUrl(Uri.parse("mailto:$_email"));
                },
                iconColor: AppColors.emailColor,
              ),
              Gap(5.h),
              _contactUsItemWidget(
                icon: FontAwesomeIcons.whatsapp,
                title: _whatsappNumber,
                onTap: () {
                  launchUrl(Uri.parse("https://wa.me/$_whatsappNumber"));
                },
                iconColor: AppColors.whatsappColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _contactUsItemWidget({
    required IconData icon,
    required String title,
    required Function onTap,
    required Color iconColor,
  }) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 25.sp,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 17.sp,
            ),
          ),
        ),
      ],
    );
  }
}
