import 'package:fpdart/fpdart.dart';

import '../../../../../exception/failure.dart';
import '../../../../../exception/server_exception.dart';
import '../../../../entities/user.dart';
import '../../../../models/user_model.dart';
import '../../domain/repository/users_repository.dart';
import '../datasources/users_remote_datasources.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDatasource usersRemoteDatasource;

  UsersRepositoryImpl({required this.usersRemoteDatasource});

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final List<UserModel> usersList =
          await usersRemoteDatasource.getAllUsers();
      final users = usersList.map((user) => user.toEntity()).toList();
      return right(users);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
