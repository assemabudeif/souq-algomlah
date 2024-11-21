import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/core/constants/app_constance.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/app_routes.dart';
import '/features/auth/repo/auth_repo.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/extensions.dart';
import '/features/profile/models/models/profile_model.dart';
import '/features/profile/views/edit_profile_view.dart';
import '/generated/locale_keys.g.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._authRepo) : super(ProfileInitial());

  final AuthRepo _authRepo;

  // final ProfileRepo _profileRepo;
  String userName = '';
  String userEmail = '';

  List<ProfileViewModel> items(BuildContext context) => [
        ProfileViewModel(
          icon: FontAwesomeIcons.user,
          title: LocaleKeys.settings_update_profile.tr(),
          onPressed: () {
            context.navigateTo(const EditProfileView());
          },
        ),
        ProfileViewModel(
          icon: Icons.lock,
          title: LocaleKeys.my_account_list_change_password.tr(),
          onPressed: () {
            context.navigateToNamed(AppRoutes.changePasswordRoute);
          },
        ),
        ProfileViewModel(
          icon: Icons.shopping_bag,
          title: LocaleKeys.my_account_list_orders.tr(),
          onPressed: () {
            context.navigateToNamed(AppRoutes.ordersRoute);
          },
        ),
        ProfileViewModel(
          icon: Icons.delete,
          title: LocaleKeys.my_account_delete_account.tr(),
          onPressed: () {
            deleteUserDialog(context);
          },
        ),
      ];

  init() async {
    userName = sl<AppPreferences>().getUserName();
    userEmail = sl<AppPreferences>().getUserEmail();
  }

  deleteUserDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocaleKeys.my_account_delete_account.tr()),
        content: Text(LocaleKeys.my_account_delete_account_assure.tr()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              LocaleKeys.general_cancel.tr(),
              style: const TextStyle(
                color: AppColors.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              deleteUser(context);
            },
            child: Text(
              LocaleKeys.my_account_delete.tr(),
              style: const TextStyle(
                color: AppColors.dangerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  deleteUser(BuildContext context) async {
    emit(DeleteUserLoading());
    final result = await _authRepo.deleteUser();
    result.fold(
      (error) {
        if ((kAppLanguageCode == "en" && error.errMsg.contains("login")) ||
            (kAppLanguageCode == "ar" && error.errMsg.contains("تسجيل"))) {
          sl<AppPreferences>().clear();
          context.navigateToNamed(AppRoutes.loginRoute);
          context.showErrorSnackBar(error.errMsg);
          return;
        }
        context.showErrorSnackBar(error.errMsg);
        emit(DeleteUserError());
      },
      (success) {
        context.showSuccessSnackBar(
          context.locale.languageCode == 'en'
              ? 'Your account has been deleted successfully'
              : 'تم حذف حسابك بنجاح',
        );
        sl<AppPreferences>().clear();
        context.navigateToNamedWithPopUntil(AppRoutes.languageRoute);
        emit(DeleteUserSuccess());
      },
    );
  }
}
