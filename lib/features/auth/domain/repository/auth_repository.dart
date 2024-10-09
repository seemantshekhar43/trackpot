import 'package:fpdart/fpdart.dart';
import 'package:appwrite/models.dart' as model;

import '../../../../core/exception/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, model.User>> signUp(
      {required String email, required String password});
  Future<Either<Failure, model.User>> logIn(
      {required String email, required String password});
  Future<model.User?> getCurrentUser();
}
