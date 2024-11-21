import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:souqalgomlah_app/core/constants/app_constance.dart';
import '/features/auth/login/model/login_model.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/features/auth/registration/views/register_otp_view.dart';
import '/generated/locale_keys.g.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/features/auth/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(LoginInitial());

  final AuthRepo _authRepo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

  dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void changePasswordVisibility() {
    emit(ChangePasswordVisibilityInitailState());
    isPasswordHidden = !isPasswordHidden;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      emit(LoginLoading());
      final result = await _authRepo.login(email, password);
      result.fold(
        (error) {
          context.showErrorSnackBar(error.errMsg);
          emit(LoginError());
        },
        (user) async {
          if (user.verified == false) {
            context.showErrorSnackBar(
              context.locale == const Locale('en')
                  ? 'Please verify your email'
                  : 'من فضلك قم بتفعيل الحساب',
            );
            context.navigateTo(RegisterOTPView(email: email));
            return;
          }

          if (context.mounted) {
            kUserId = user.id;
            await _saveDataToSharedPref(
              context: context,
              userId: user.id,
              userName: user.username,
              token: user.token,
              loginModel: user,
              userEmail: emailController.text,
            );

            context.navigateToNamedWithPopUntil(AppRoutes.homeRoute);
          }
          emit(LoginSuccess());
        },
      );
    } else {
      context.showErrorSnackBar(LocaleKeys.general_required_field.tr());
      emit(LoginError());
    }
  }

  void resetPassword(BuildContext context) {
    context.navigateToNamedWithArguments(
      AppRoutes.forgetPasswordRoute,
      emailController.text,
    );
  }

  void register(BuildContext context) {
    context.navigateToNamed(AppRoutes.registerRoute);
  }

  _saveDataToSharedPref({
    required BuildContext context,
    required String userId,
    required String userName,
    required String userEmail,
    required String token,
    required LoginModel loginModel,
  }) async {
    await Future.wait([
      sl<AppPreferences>().setToken(token),
      sl<AppPreferences>().setUserId(userId),
      sl<AppPreferences>().setUserName(userName),
      sl<AppPreferences>().setUserEmail(userEmail),
      sl<AppPreferences>().setLoginModel(loginModel),

      // Remove Is Guest user
      sl<AppPreferences>().removeGustUser(),
    ]).then((value) async {
      await sl<AppPreferences>().init(context, fromLogin: true);
    });
  }
}
