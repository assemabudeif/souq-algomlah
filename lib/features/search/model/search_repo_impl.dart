import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/data/models/product_model.dart';

import '/core/errors/fauilers.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';

import 'search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  @override
  Future<Either<Failure, List<ProductModel>>> search({
    required String searchText,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.search(searchText),
      );

      final List<ProductModel> products =
          (response.data as List).map((e) => ProductModel.fromJson(e)).toList();

      return Right(products);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
