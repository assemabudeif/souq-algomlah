import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/data/models/category_model.dart';

import '/core/errors/fauilers.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';

import 'category_details_repo.dart';

class CategoryDetailsRepoImpl extends CategoryDetailsRepo {
  @override
  Future<Either<Failure, CategoryModel>> getCategoryDetails({
    required String categoryId,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getCategory(categoryId),
      );

      return Right(CategoryModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
