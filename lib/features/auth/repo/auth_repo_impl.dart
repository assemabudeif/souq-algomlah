import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/constants/app_constance.dart';
import '/features/auth/login/model/login_model.dart';
import '/features/auth/registration/models/register_model.dart';
import '/core/data/requests/register_request.dart';
import '/core/errors/fauilers.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';
import '/features/auth/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure, RewgisterModel>> register(RegisterRequest user) async {
    try {
      final response = await DioLogger.getDio().post(
        ApiConstance.register,
        data: user.toJson(),
        queryParameters: {
          if (kAppLanguageCode == 'en') 'lang': 'en',
        },
      );

      return Right(RewgisterModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login(
      String email, String password) async {
    try {
      final response = await DioLogger.getDio().post(
        ApiConstance.login,
        data: {
          'user': email,
          'password': password,
        },
        queryParameters: {
          if (kAppLanguageCode == 'en') 'lang': 'en',
        },
      );

      return Right(LoginModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await DioLogger.getDio().post(
        ApiConstance.verify(email),
        data: {
          'otp': otp,
        },
        queryParameters: {
          if (kAppLanguageCode == 'en') 'lang': 'en',
        },
      );

      return Right(response.data['message'] as String? ?? '');
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String password,
    required String otp,
  }) async {
    try {
      final response = await DioLogger.getDio().post(
        ApiConstance.resetPassword(email),
        data: {
          'otp': otp,
          'password': password,
        },
        queryParameters: {
          if (kAppLanguageCode == 'en') 'lang': 'en',
        },
      );

      return Right(response.data['message'] as String? ?? '');
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendOTPForResetPassword(String email) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.sendOTPForResetPassword(email),
      );

      return Right(response.data['message'] as String? ?? '');
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOTPForResetPassword({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await DioLogger.getDio().post(
        ApiConstance.verifyOTPForResetPassword(email),
        data: {
          'otp': otp,
        },
        queryParameters: {
          if (kAppLanguageCode == 'en') 'lang': 'en',
        },
      );

      return Right(response.data['message'] as String? ?? '');
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUser() async {
    try {
      final response = await DioLogger.getDio().delete(
        ApiConstance.deleteUser,
        queryParameters: {
          if (kAppLanguageCode == 'en') 'lang': 'en',
        },
      );

      return Right(response.data['message'] as String? ?? '');
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resendOTP(String email) async {
    try {
      final response = await DioLogger.getDio().post(
        ApiConstance.resendOTP(email),
      );

      return Right(response.data['message'] as String? ?? '');
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
