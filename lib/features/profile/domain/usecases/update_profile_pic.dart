import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/profile_repository.dart';

class UpdateProfilePic implements UseCase<void, UpdateProfilePicParams> {
  final ProfileRepository profileRepository;
  const UpdateProfilePic(this.profileRepository);

  @override
  Future<Either<Failure, String>> call(UpdateProfilePicParams params) async {
    return await profileRepository.updateUserProfilePic(user: params.user, file: params.fIle);
  }
}

class UpdateProfilePicParams{
  final User user;
  final File fIle;

  UpdateProfilePicParams({required this.user, required this.fIle});


}