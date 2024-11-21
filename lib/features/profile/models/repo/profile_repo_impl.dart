import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/constants/app_constance.dart';
import '/core/data/models/profile_model.dart';
import '/core/data/requests/register_request.dart';
import '/core/errors/fauilers.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';
import '/features/profile/models/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  @override
  Future<Either<Failure, ProfileModel>> editProfile(
    RegisterRequest request,
  ) async {
    try {
      final response = await DioLogger.getDio().put(
        ApiConstance.updateProfile,
        data: request.toJson(),
        queryParameters: {
          if (kAppLanguageCode == 'en') 'lang': 'en',
        },
      );

      return Right(ProfileModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> changePassword(String password) async {
    try {
      final response = await DioLogger.getDio().put(
        ApiConstance.updateProfile,
        data: {
          'password': password,
        },
        queryParameters: {
          if (kAppLanguageCode == 'en') 'lang': 'en',
        },
      );

      return Right(ProfileModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
