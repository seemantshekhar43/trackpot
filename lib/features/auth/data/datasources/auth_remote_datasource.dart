import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite_model;
import 'package:trackpot/core/common/models/user_model.dart';
import '../../../../../core/exception/server_exception.dart';
import '../../../../core/constants/appwrite_constants.dart';
import '../../../../core/constants/appwrite_exception_types_constants.dart';
import '../../../../core/exception/appwrite_custom_exception.dart';
import '../../../../core/secrets/app_secrets.dart';

abstract interface class AuthRemoteDataSource {
  Future<appwrite_model.User> signUpWithEmailPassword({
    required String email,
    required String password,
  });
  Future<appwrite_model.Session> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<appwrite_model.User?> getCurrentUser();
  Future<UserModel> getCurrentUserDetails(String id);
  Future<void> deleteCurrentSession();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Account _appwriteAccount;
  final Databases _appwriteDB;
  AuthRemoteDataSourceImpl(Account appwriteAccount, Databases appwriteDB)
      : _appwriteAccount = appwriteAccount,
        _appwriteDB = appwriteDB;

  @override
  Future<appwrite_model.Session> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final appwrite_model.Session session =
          await _appwriteAccount.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return session;
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<appwrite_model.User> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final appwrite_model.User user = await _appwriteAccount.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return user;
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<appwrite_model.User?> getCurrentUser() async {
    try {
      return await _appwriteAccount.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel> getCurrentUserDetails(String id) async {
    try {
      final appwrite_model.Document document = await _appwriteDB.getDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: id,
      );
      return UserModel.fromMap(document.data);
    } on AppwriteException catch (e) {
      if (AppwriteExceptionTypesConstants.documentNotFound == e.type) {
        throw AppwriteDocumentNotFoundException(
            e.message ?? 'Some unexpected error occurred');
      }
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteCurrentSession() async {
    try {
      await _appwriteAccount.deleteSession(
        sessionId: 'current',
      );
      return;
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
