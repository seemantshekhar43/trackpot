import 'package:appwrite/models.dart' as appwrite;
import 'package:fpdart/fpdart.dart';
import 'package:trackpot/core/common/models/user_model.dart';
import '../../../../core/exception/appwrite_custom_exception.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/constants/exception_constants.dart';
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
  Future<Either<Failure, appwrite.User>> getCurrentUser() async {
    try {
      if (!await (networkConnectionChecker.isConnected)) {
        return left(Failure(message: ExceptionConstants.noNetworkConnection));
      }

      final user = await remoteDataSource.getCurrentUser();
      if (user != null) {
        return right(user);
      }
      return left(Failure(
          type: ExceptionConstants.userSessionNotFound,
          message: ExceptionConstants.userSessionNotFound));
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, appwrite.User>> logIn(
      {required String email, required String password}) async {
    try {
      if (!await (networkConnectionChecker.isConnected)) {
        return left(Failure(message: ExceptionConstants.noNetworkConnection));
      }
      await remoteDataSource
          .loginWithEmailPassword(email: email, password: password);

      final user = await remoteDataSource.getCurrentUser();

      return right(user!);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, appwrite.User>> signUp(
      {required String email, required String password}) async {
    try {
      if (!await (networkConnectionChecker.isConnected)) {
        return left(Failure(message: ExceptionConstants.noNetworkConnection));
      }
      final user = await remoteDataSource.signUpWithEmailPassword(
          email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUserDetails(
      {required String id}) async {
    try {
      if (!await (networkConnectionChecker.isConnected)) {
        return left(Failure(message: ExceptionConstants.noNetworkConnection));
      }
      final UserModel user = await remoteDataSource.getCurrentUserDetails(id);

      return right(user.toEntity());
    } on AppwriteDocumentNotFoundException catch (e) {
      return left(Failure(
          type: ExceptionConstants.userDoesNotExist, message: e.message));
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async{
    try {
      if (!await (networkConnectionChecker.isConnected)) {
        return left(Failure(message: ExceptionConstants.noNetworkConnection));
      }
      await remoteDataSource.deleteCurrentSession();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

}
