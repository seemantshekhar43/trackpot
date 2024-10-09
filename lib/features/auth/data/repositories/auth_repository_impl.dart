import 'package:appwrite/models.dart' as appwrite;
import 'package:fpdart/fpdart.dart';
import 'package:trackpot/core/exception/exception_constants.dart';
import '../../../../core/exception/failure.dart';
import '../../../../core/exception/server_exception.dart';
import '../../../../core/network/network_connection_checker.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkConnectionChecker networkConnectionChecker;
  const AuthRepositoryImpl(
      this.remoteDataSource, this.networkConnectionChecker);

  @override
  Future<appwrite.User?> getCurrentUser() => remoteDataSource.getCurrentUser();

  @override
  Future<Either<Failure, appwrite.User>> logIn(
      {required String email, required String password}) async {
    try {
      if (!await (networkConnectionChecker.isConnected)) {
        return left(Failure(ExceptionConstants.noNetworkConnection));
      }
      final appwrite.Session session = await remoteDataSource
          .loginWithEmailPassword(email: email, password: password);

      final user = await getCurrentUser();

      return right(user!);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, appwrite.User>> signUp(
      {required String email, required String password}) async {
    try {
      if (!await (networkConnectionChecker.isConnected)) {
        return left(Failure(ExceptionConstants.noNetworkConnection));
      }
      final user = await remoteDataSource.signUpWithEmailPassword(
          email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
