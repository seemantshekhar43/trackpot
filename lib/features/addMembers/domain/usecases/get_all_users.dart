import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/common/features/users/domain/repository/users_repository.dart';
import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetAllUsers implements UseCase<List<User>, NoParams> {
  final UsersRepository repository;

  GetAllUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) {
    return repository.getAllUsers();
  }
}
