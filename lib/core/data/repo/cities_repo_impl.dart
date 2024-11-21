import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/data/models/cities_model.dart';
import '/core/data/repo/cities_repo.dart';
import '/core/errors/fauilers.dart';
import '/core/utilities/dio_logger.dart';

import '../../network/api_constance.dart';

class CitiesRepoImpl extends CitiesRepo {
  @override
  Future<Either<Failure, List<CityModel>>> getCities() async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getCities,
      );
      final List<CityModel> cities =
          (response.data as List).map((e) => CityModel.fromJson(e)).toList();
      return Right(cities);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
