import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/exception/failure.dart';

abstract interface class ProfileRepository{
  Future<Either<Failure, void>> updateUserData(User user);
}