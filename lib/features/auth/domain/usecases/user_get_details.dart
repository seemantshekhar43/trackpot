import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserGetDetails implements UseCase<User, UserGetDetailsParams> {
  final AuthRepository authRepository;
  const UserGetDetails(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserGetDetailsParams params) async {
    return await authRepository.getCurrentUserDetails(id: params.id);
  }
}

class UserGetDetailsParams {
  final String id;

  UserGetDetailsParams({
    required this.id,
  });
}
