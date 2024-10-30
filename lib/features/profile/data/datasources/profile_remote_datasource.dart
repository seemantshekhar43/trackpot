import 'package:appwrite/appwrite.dart';

import '../../../../core/constants/appwrite_constants.dart';
import '../../../../core/exception/server_exception.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../../../../core/common/models/user_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<void> updateUserData(UserModel user);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Databases _appwriteDB;

  ProfileRemoteDataSourceImpl({required Databases appwriteDB})
      : _appwriteDB = appwriteDB;
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
}
