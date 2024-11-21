import 'package:dartz/dartz.dart';
import '/core/data/models/profile_model.dart';
import '/core/data/requests/register_request.dart';
import '/core/errors/fauilers.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> editProfile(RegisterRequest request);

  Future<Either<Failure, ProfileModel>> changePassword(String password);
}
