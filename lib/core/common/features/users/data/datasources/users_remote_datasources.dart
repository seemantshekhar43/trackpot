import 'package:appwrite/appwrite.dart';

import '../../../../../constants/appwrite_constants.dart';
import '../../../../../exception/server_exception.dart';
import '../../../../../secrets/app_secrets.dart';
import '../../../../models/user_model.dart';

abstract class UsersRemoteDatasource {
  Future<List<UserModel>> getAllUsers();
}

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {
  final Databases _db;

  UsersRemoteDatasourceImpl({required Databases db}) : _db = db;

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final result = await _db.listDocuments(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.usersCollection,
      );
      return result.documents
          .map((document) => UserModel.fromMap(document.data))
          .toList();
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
