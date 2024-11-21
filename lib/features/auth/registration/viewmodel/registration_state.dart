part of 'registration_cubit.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class ChangePasswordVisibilityInitailState extends RegistrationState {}

class ChangePasswordVisibilityState extends RegistrationState {}

class ChangeAgreeWithPrivacyInitialState extends RegistrationState {}

class ChangeAgreeWithPrivacyState extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailed extends RegistrationState {}

class VerifyOTPLoading extends RegistrationState {}

class VerifyOTPFailed extends RegistrationState {}

class VerifyOTPSuccess extends RegistrationState {}

class ResendOTPLoading extends RegistrationState {}

class ResendOTPSuccess extends RegistrationState {}

class ResendOTPError extends RegistrationState {}
