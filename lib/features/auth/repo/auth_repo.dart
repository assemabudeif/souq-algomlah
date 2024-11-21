import 'package:dartz/dartz.dart';
import '/features/auth/login/model/login_model.dart';
import '/features/auth/registration/models/register_model.dart';
import '/core/data/requests/register_request.dart';
import '/core/errors/fauilers.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginModel>> login(String email, String password);

  Future<Either<Failure, RewgisterModel>> register(RegisterRequest user);

  Future<Either<Failure, String>> deleteUser();

  Future<Either<Failure, String>> verifyEmail({
    required String email,
    required String otp,
  });

  Future<Either<Failure, String>> resendOTP(String email);

  /// Reset Password
  Future<Either<Failure, String>> sendOTPForResetPassword(String email);

  Future<Either<Failure, String>> verifyOTPForResetPassword({
    required String email,
    required String otp,
  });

  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String password,
    required String otp,
  });
}
