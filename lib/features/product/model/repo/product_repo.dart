import 'package:dartz/dartz.dart';
import 'package:souqalgomlah_app/features/product/model/models/product_model.dart';
import '/core/errors/fauilers.dart';

abstract class ProductRepo {
  Future<Either<Failure, ProductModel>> getProduct(String productId);
}
