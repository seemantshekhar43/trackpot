import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../repository/profile_repository.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/usecase/usecase.dart';

class UpdateUserData implements UseCase<void, User> {
  final ProfileRepository profileRepository;
  const UpdateUserData(this.profileRepository);

  @override
  Future<Either<Failure, void>> call(User user) async {
    return await profileRepository.updateUserData(user);
  }
}
