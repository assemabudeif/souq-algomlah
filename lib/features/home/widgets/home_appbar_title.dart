import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/generated/assets.dart';

homeAppBarTitle(BuildContext context) {
  // ignore: unused_local_variable
  final city = context.locale == const Locale('en')
      ? sl<AppPreferences>().getLoginModel().address.cityEnglish
      : sl<AppPreferences>().getLoginModel().address.city;
  final wallet = sl<AppPreferences>().getLoginModel().wallet;
  return Row(
    children: [
      if (!sl<AppPreferences>().getGustUser()) ...[
        SvgPicture.asset(
          Assets.assetsSvgsWallet,
          height: 2.h,
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcIn,
          ),
        ),
        Gap(2.w),
        Text(
          '$wallet\n${context.locale == const Locale('en') ? 'Wallet Balance' : 'رصيد محفظتك'}',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.start,
        ),
        Gap(5.w)
      ],
      // Expanded(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         LocaleKeys.home_delivering_to.tr(),
      //         style: TextStyle(
      //           fontSize: 16.sp,
      //           color: Colors.black,
      //           fontWeight: FontWeight.normal,
      //         ),
      //       ),
      //       Row(
      //         children: [
      //           const Icon(
      //             Icons.keyboard_arrow_down,
      //             color: AppColors.blackColor,
      //           ),
      //           Expanded(
      //             child: Text(
      //               city,
      //               style: TextStyle(
      //                 fontSize: 16.sp,
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.normal,
      //               ),
      //               maxLines: 1,
      //               overflow: TextOverflow.ellipsis,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    ],
  );
}
