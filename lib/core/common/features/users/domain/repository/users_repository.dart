import 'package:fpdart/fpdart.dart';

import '../../../../../exception/failure.dart';
import '../../../../entities/user.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<User>>> getAllUsers();
}
