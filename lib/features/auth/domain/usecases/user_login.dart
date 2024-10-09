import 'package:fpdart/fpdart.dart';
import 'package:appwrite/models.dart' as model;
import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserLogin implements UseCase<model.User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, model.User>> call(UserLoginParams params) async {
    return await authRepository.logIn(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
