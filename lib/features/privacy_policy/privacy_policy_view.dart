import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';
import '/generated/locale_keys.g.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<PrivacyPolicyModel> _policyList = [
    PrivacyPolicyModel(
      title: LocaleKeys.privacy_policy_points_policy.tr(),
      content: LocaleKeys.privacy_policy_points_policy_content.tr(),
    ),
    PrivacyPolicyModel(
      title: LocaleKeys.privacy_policy_delivery_policy.tr(),
      content: LocaleKeys.privacy_policy_delivery_policy_content.tr(),
    ),
    PrivacyPolicyModel(
      title: LocaleKeys.privacy_policy_delivery_return_policy.tr(),
      content: LocaleKeys.privacy_policy_delivery_return_policy_content.tr(),
    ),
    PrivacyPolicyModel(
      title: LocaleKeys.privacy_policy_exchange_or_return.tr(),
      content: LocaleKeys.privacy_policy_exchange_or_return_content.tr(),
    ),
  ];

  final List<PrivacyPolicyModel> _privacyList = [
    PrivacyPolicyModel(
      title: LocaleKeys.privacy_policy_data_collected.tr(),
      content: LocaleKeys.privacy_policy_data_collected_content.tr(),
    ),
    PrivacyPolicyModel(
      title: LocaleKeys.privacy_policy_data_collection_use.tr(),
      content: LocaleKeys.privacy_policy_data_collection_use_content.tr(),
    ),
    PrivacyPolicyModel(
      title: LocaleKeys.privacy_policy_data_security.tr(),
      content: LocaleKeys.privacy_policy_data_security_content.tr(),
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.home_drawer_policy_privacy.tr(),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.center,
            dividerColor: AppColors.whiteColor,
            tabs: [
              Tab(
                text: LocaleKeys.privacy_policy_policy.tr(),
              ),
              Tab(
                text: LocaleKeys.privacy_policy_privacy.tr(),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: 2.h,
                horizontal: 3.w,
              ),
              itemBuilder: (context, index) {
                return _buildPolicyItem(_policyList[index]);
              },
              separatorBuilder: (context, index) => Gap(2.h),
              itemCount: _policyList.length,
            ),
            ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: 2.h,
                horizontal: 3.w,
              ),
              itemBuilder: (context, index) {
                return _buildPolicyItem(_privacyList[index]);
              },
              separatorBuilder: (context, index) => Gap(2.h),
              itemCount: _privacyList.length,
            ),
          ],
        ),
      ),
    );
  }

  _buildPolicyItem(PrivacyPolicyModel policyModel) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            color: AppColors.greyColor.withOpacity(0.3),
            width: 100.w,
            child: Text(
              policyModel.title,
              style: TextStyle(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(3.w),
            color: AppColors.lightPrimary,
            child: Text(
              policyModel.content,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyModel extends Equatable {
  final String title;
  final String content;

  const PrivacyPolicyModel({
    required this.title,
    required this.content,
  });

  @override
  List<Object?> get props => [title, content];
}
