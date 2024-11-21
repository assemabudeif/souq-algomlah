import 'package:dartz/dartz.dart';
import '/core/data/models/product_model.dart';
import '/core/errors/fauilers.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<ProductModel>>> search({
    required String searchText,
  });
}
