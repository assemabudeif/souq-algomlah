part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordOtpSubmittedInitial extends ForgetPasswordState {}

class ForgetPasswordOtpSubmitted extends ForgetPasswordState {}

class SendOTPLoading extends ForgetPasswordState {}

class SendOTPSuccess extends ForgetPasswordState {}

class SendOTPFailed extends ForgetPasswordState {}

class ResetPasswordLoading extends ForgetPasswordState {}

class ResetPasswordSuccess extends ForgetPasswordState {}

class ResetPasswordFailed extends ForgetPasswordState {}

class VerifyOTPLoading extends ForgetPasswordState {}

class VerifyOTPSuccess extends ForgetPasswordState {}

class VerifyOTPFailed extends ForgetPasswordState {}

class TogglePasswordVisibility extends ForgetPasswordState {}

class TogglePasswordVisibilitySuccess extends ForgetPasswordState {}

class ToggleConfirmPasswordVisibility extends ForgetPasswordState {}

class ToggleConfirmPasswordVisibilitySuccess extends ForgetPasswordState {}
