import 'package:appwrite/models.dart' as appwrite;
import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserGetCurrentUser implements UseCase<appwrite.User, NoParams> {
  final AuthRepository authRepository;
  const UserGetCurrentUser(this.authRepository);

  @override
  Future<Either<Failure, appwrite.User>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
