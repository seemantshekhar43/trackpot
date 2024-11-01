import 'dart:io';

import 'package:appwrite/appwrite.dart';

import '../../../../core/constants/appwrite_constants.dart';
import '../../../../core/exception/server_exception.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../../../../core/common/models/user_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<void> updateUserData(UserModel user);
  Future<String> uploadProfilePicture(File file);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Databases _appwriteDB;
  final Storage _storage;

  ProfileRemoteDataSourceImpl(
      {required Databases appwriteDB, required Storage storage})
      : _appwriteDB = appwriteDB,
        _storage = storage;
  @override
  Future<void> updateUserData(UserModel user) async {
    try {
      await _appwriteDB.updateDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: user.id,
        data: user.toMap(),
      );
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadProfilePicture(File picture) async {
    try {
      final uploadResult = await _storage.createFile(
        bucketId: AppwriteConstants.profilePicBucket,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: picture.path),
      );

      return uploadResult.$id;
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
