import 'package:dartz/dartz.dart';
import 'package:souqalgomlah_app/core/errors/fauilers.dart';

abstract class AppVersionRepo {
  Future<Either<Failure, String>> getAppVersion();
}
