import 'package:fpdart/fpdart.dart';
import 'package:appwrite/models.dart' as model;
import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserSignup implements UseCase<model.User, UserSignupParams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, model.User>> call(UserSignupParams params) async {
    return await authRepository.signUp(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String email;
  final String password;

  UserSignupParams({
    required this.email,
    required this.password,
  });
}
