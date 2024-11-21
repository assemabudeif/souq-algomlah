import 'package:dartz/dartz.dart';
import '/core/data/models/cities_model.dart';
import '/core/errors/fauilers.dart';

abstract class CitiesRepo {
  Future<Either<Failure, List<CityModel>>> getCities();
}
