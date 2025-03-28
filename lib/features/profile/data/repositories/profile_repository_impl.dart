import 'dart:io';

import 'package:fpdart/fpdart.dart';
import '../../../../core/exception/server_exception.dart';
import '../datasources/profile_remote_datasource.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/exception/failure.dart';
import '../../domain/repository/profile_repository.dart';
import '../../../../core/common/models/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Either<Failure, void>> updateUserData(User user) async {
    try {
      final userModel = UserModel(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        username: user.username,
        location: user.location,
        currency: user.currency,
        profilePicture: user.profilePicture,
      );
      await profileRemoteDataSource.updateUserData(userModel);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateUserProfilePic({required File file, required User user}) async {
    try {
      final profilePicId = await profileRemoteDataSource.uploadProfilePicture(file);
      final userModel = UserModel(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        username: user.username,
        location: user.location,
        currency: user.currency,
        profilePicture: profilePicId,
      );
      await profileRemoteDataSource.updateUserData(userModel);
      return right(profilePicId);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
