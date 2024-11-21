import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/features/profile/models/repo/profile_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._profileRepo) : super(ChangePasswordInitial());
  final ProfileRepo _profileRepo;

  final formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> changePassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(ChangePasswordLoading());
      final result = await _profileRepo.changePassword(
        newPasswordController.text,
      );
      result.fold(
        (failure) {
          if ((kAppLanguageCode == "en" && failure.errMsg.contains("login")) ||
              (kAppLanguageCode == "ar" && failure.errMsg.contains("تسجيل"))) {
            sl<AppPreferences>().clear();
            context.navigateToNamed(AppRoutes.loginRoute);
            context.showErrorSnackBar(failure.errMsg);
            return;
          }
          context.showErrorSnackBar(failure.errMsg);
          emit(ChangePasswordFailure());
        },
        (data) {
          context.navigateToNamedWithPopUntil(AppRoutes.homeRoute);
          emit(ChangePasswordSuccess());
        },
      );
    }
  }
}
