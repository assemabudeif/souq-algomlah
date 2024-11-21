import 'package:dartz/dartz.dart';
import '/core/data/models/category_model.dart';
import '/core/errors/fauilers.dart';

abstract class CategoryDetailsRepo {
  Future<Either<Failure, CategoryModel>> getCategoryDetails({
    required String categoryId,
  });
}
