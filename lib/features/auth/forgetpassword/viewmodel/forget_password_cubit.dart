import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/features/auth/forgetpassword/views/reset_password_view.dart';
import '/features/auth/repo/auth_repo.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._authRepo) : super(ForgetPasswordInitial());

  final AuthRepo _authRepo;

  /// Forget Password
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  /// OTP
  String otp = '';

  /// Reset Password
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  /// Forget Password

  Future<void> sendOtp(BuildContext context) async {
    if (forgetPasswordFormKey.currentState?.validate() ?? false) {
      emit(SendOTPLoading());
      final result =
          await _authRepo.sendOTPForResetPassword(emailController.text);
      result.fold(
        (l) {
          if (l.errMsg.contains('Not Found ')) {
            context.showErrorSnackBar(
              context.locale == const Locale('en')
                  ? 'Email not found'
                  : 'البريد الالكتروني غير موجود',
            );
          } else {
            context.showErrorSnackBar(l.errMsg);
          }
          emit(SendOTPFailed());
        },
        (r) {
          context.showSuccessSnackBar(r);
          context.navigateToNamedWithArguments(
            AppRoutes.otpRoute,
            emailController.text,
          );
          emit(SendOTPSuccess());
        },
      );
    }
  }

  /// OTP

  void verifyOTP({
    required BuildContext context,
    required String email,
  }) async {
    emit(VerifyOTPLoading());
    log('email: $email, otp: $otp');
    final result = await _authRepo.verifyOTPForResetPassword(
      email: email,
      otp: otp,
    );
    result.fold(
      (l) {
        context.showErrorSnackBar(l.errMsg);
        emit(VerifyOTPFailed());
      },
      (r) {
        context.showSuccessSnackBar(r);
        context.navigateToNamedWithReplacementAndArguments(
          AppRoutes.resetPasswordRoute,
          ResetPasswordViewParams(
            email: email,
            otp: otp,
          ),
        );
        emit(VerifyOTPSuccess());
      },
    );
  }

  void submtOtp(String otp) {
    emit(ForgetPasswordOtpSubmittedInitial());
    this.otp = otp;
    emit(ForgetPasswordOtpSubmitted());
  }

  void reSendOTP({
    required BuildContext context,
    required String email,
  }) async {
    emit(SendOTPLoading());
    final result = await _authRepo.sendOTPForResetPassword(email);
    result.fold(
      (l) {
        context.showErrorSnackBar(l.errMsg);
        emit(SendOTPFailed());
      },
      (r) {
        context.showSuccessSnackBar(r);
        emit(SendOTPSuccess());
      },
    );
  }

  /// Reset Password
  void resetPassword({
    required BuildContext context,
    required String email,
    required String otp,
  }) async {
    if (resetPasswordFormKey.currentState?.validate() ?? false) {
      emit(ResetPasswordLoading());
      final result = await _authRepo.resetPassword(
        email: email,
        password: newPasswordController.text,
        otp: otp,
      );
      result.fold(
        (l) {
          context.showErrorSnackBar(l.errMsg);
          emit(ResetPasswordFailed());
        },
        (r) {
          context.showSuccessSnackBar(r);
          context.navigateToNamedWithReplacement(AppRoutes.loginRoute);
          emit(ResetPasswordSuccess());
        },
      );
    }
  }

  void togglePasswordVisibility() {
    emit(TogglePasswordVisibility());
    isPasswordHidden = !isPasswordHidden;
    emit(TogglePasswordVisibilitySuccess());
  }

  void toggleConfirmPasswordVisibility() {
    emit(ToggleConfirmPasswordVisibility());
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    emit(ToggleConfirmPasswordVisibilitySuccess());
  }
}
