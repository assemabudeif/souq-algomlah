
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:souqalgomlah_app/features/product/model/models/product_model.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';
import 'package:souqalgomlah_app/features/product/model/repo/product_repo.dart';
import '/core/errors/fauilers.dart';

class ProductRepoImpl extends ProductRepo {
  @override
  Future<Either<Failure, ProductModel>> getProduct(String productId) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getProduct(productId),
      );

      // log(response.data.toString(), name: 'product response');

      return Right(ProductModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
