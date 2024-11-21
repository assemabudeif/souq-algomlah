import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/global/widgets/check_connectivity.dart';
import '/core/functions/logout.dart';
import '/core/services/services_locator.dart';
import '/features/profile/viewmodels/profile/profile_cubit.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/profile/views/widgets/profile_item_widget.dart';
import '/generated/assets.dart';
import '/generated/locale_keys.g.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _vm = sl<ProfileCubit>();

  @override
  void initState() {
    _vm.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => _vm,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.my_account_title.tr(),
          ),
        ),
        body: CheckInternetConnectionView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 18.5.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Assets.assetsSvgsMyAccount,
                    height: 7.h,
                    colorFilter: const ColorFilter.mode(
                      AppColors.whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Gap(1.5.h),
                Text(
                  _vm.userName,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontManager.mediumFontWeight,
                    color: AppColors.blackColor,
                    height: 1,
                  ),
                ),
                Text(
                  _vm.userEmail,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontManager.mediumFontWeight,
                    color: AppColors.hintColor,
                  ),
                ),
                Gap(2.h),
                ..._vm.items(context).map((e) {
                  return ProfileItemWidget(model: e);
                }),
                Gap(1.h),
                CustomLoadingButton(
                  onPressed: () {
                    logout(context);
                  },
                  height: 7.5.h,
                  text: LocaleKeys.my_account_logout.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
