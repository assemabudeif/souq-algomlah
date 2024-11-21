import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/features/auth/registration/views/register_otp_view.dart';
import '/generated/locale_keys.g.dart';
import '/core/data/requests/register_request.dart';
import '/core/errors/fauilers.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/features/auth/repo/auth_repo.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._authRepo) : super(RegistrationInitial());

  final AuthRepo _authRepo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();

  // final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController additionalPhoneController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool isAgreeWithPriavacy = false;

  /// Address Fields
  final TextEditingController blockController = TextEditingController();
  final TextEditingController gadeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController apartmentNoController = TextEditingController();

  String selectedCity = '';

  dispose() {
    fullNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    additionalPhoneController.dispose();
    blockController.dispose();
    gadeController.dispose();
    streetController.dispose();
    houseNoController.dispose();
    floorController.dispose();
    apartmentNoController.dispose();
  }

  void changePasswordVisibility() {
    emit(ChangePasswordVisibilityInitailState());
    isPasswordHidden = !isPasswordHidden;
    emit(ChangePasswordVisibilityState());
  }

  void changeAgreeWithPrivacy() {
    emit(ChangeAgreeWithPrivacyInitialState());
    isAgreeWithPriavacy = !isAgreeWithPriavacy;
    emit(ChangeAgreeWithPrivacyState());
  }

  Future<void> register(BuildContext context) async {
    if (!isAgreeWithPriavacy) {
      context.showErrorSnackBar(
        LocaleKeys.auth_you_must_agree_with_privacy_policy.tr(),
      );
      return;
    } else if (selectedCity == "") {
      context.showErrorSnackBar(
        LocaleKeys.auth_you_must_choose_city.tr(),
      );
      return;
    } else if (formKey.currentState!.validate()) {
      emit(RegistrationLoading());
      var regex = RegExp(r'^[569]\d{7}$');
      if (phoneController.text != "" && !regex.hasMatch(phoneController.text)) {
        context.showErrorSnackBar(
          context.locale == const Locale('en')
              ? 'Phone number must start with 5, 6 or 9 and be 8 digits long'
              : 'يجب أن يبدأ رقم الهاتف بـ 5 أو 6 أو 9 ويكون طوله 8 أرقام',
        );
        emit(RegistrationFailed());
        return;
      }

      final result = await _authRepo.register(
        RegisterRequest(
          name: fullNameController.text,
          email: emailController.text,
          phone: phoneController.text,
          secondPhone: additionalPhoneController.text,
          password: passwordController.text,
          city: selectedCity,
          governorate: blockController.text,
          street: streetController.text,
          homeNumber: houseNoController.text,
          floorNumber: floorController.text,
          flatNumber: apartmentNoController.text,
          description: gadeController.text,
        ),
      );

      result.fold(
        (l) {
          context.showErrorSnackBar(
            l is ServerFailure ? l.errMsg : 'Something went wrong',
          );
          emit(RegistrationFailed());
        },
        (r) {
          context.showSuccessSnackBar('User Registered Successfully');
          if (context.mounted) {
            context.navigateTo(RegisterOTPView(
              email: emailController.text,
            ));
          }
          emit(RegistrationSuccess());
        },
      );
    } else {
      context.showErrorSnackBar(
        LocaleKeys.general_required_field.tr(),
      );
      emit(RegistrationFailed());
    }
  }

  void login(BuildContext context) {
    context.navigateToNamed(AppRoutes.loginRoute);
  }

  /// OTP Verification

  /// OTP Fields
  final otpFormKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  disposeOTP() {
    otpController.dispose();
  }

  void verifyOTP(BuildContext context, String email) async {
    if (otpFormKey.currentState!.validate()) {
      emit(VerifyOTPLoading());
      final result = await _authRepo.verifyEmail(
        email: email,
        otp: otpController.text,
      );

      result.fold(
        (l) {
          context.showErrorSnackBar(
            l is ServerFailure ? l.errMsg : 'Something went wrong',
          );
          emit(VerifyOTPFailed());
        },
        (r) {
          context.showSuccessSnackBar(r);
          context.navigateToNamedWithPopUntil(AppRoutes.loginRoute);
          emit(VerifyOTPSuccess());
        },
      );
    }
  }

  void resendOTP(BuildContext context, String email) async {
    emit(ResendOTPLoading());
    final result = await _authRepo.resendOTP(email);
    result.fold(
      (failure) {
        context.showErrorSnackBar(
          failure is ServerFailure ? failure.errMsg : 'Something went wrong',
        );
        emit(ResendOTPError());
      },
      (success) {
        context.showSuccessSnackBar(
          context.locale == const Locale('en')
              ? 'OTP Sent Successfully'
              : 'تم إرسال رمز التحقق بنجاح',
        );
        emit(ResendOTPSuccess());
      },
    );
  }
}
