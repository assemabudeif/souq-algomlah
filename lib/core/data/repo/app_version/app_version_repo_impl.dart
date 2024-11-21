import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/errors/fauilers.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';

import 'app_version_repo.dart';

class AppVersionRepoImpl extends AppVersionRepo {
  @override
  Future<Either<Failure, String>> getAppVersion() async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.currentVersion,
      );

      return Right(response.data['version'] ?? '');
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
