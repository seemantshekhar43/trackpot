import 'dart:io';

import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/exception/failure.dart';

abstract interface class ProfileRepository{
  Future<Either<Failure, void>> updateUserData(User user);
  Future<Either<Failure, String>> updateUserProfilePic({required File file, required User user});

}