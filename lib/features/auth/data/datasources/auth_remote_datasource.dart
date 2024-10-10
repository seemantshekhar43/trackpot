import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwriteModel;
import '../../../../core/constants/appwrite_exception_types_constants.dart';
import '../../../../core/exception/appwrite_custom_exception.dart';
import '../../../../../core/exception/server_exception.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/constants/appwrite_constants.dart';
import '../../../../core/secrets/app_secrets.dart';

abstract interface class AuthRemoteDataSource {
  Future<appwriteModel.User> signUpWithEmailPassword({
    required String email,
    required String password,
  });
  Future<appwriteModel.Session> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<appwriteModel.User?> getCurrentUser();
  Future<User> getCurrentUserDetails(String id);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Account _appwriteAccount;
  final Databases _appwriteDB;
  AuthRemoteDataSourceImpl(
      Account appwriteAccount, Databases appwriteDB)
      : _appwriteAccount = appwriteAccount,
        _appwriteDB = appwriteDB;

  @override
  Future<appwriteModel.Session> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final appwriteModel.Session session =
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
  Future<appwriteModel.User> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final appwriteModel.User user = await _appwriteAccount.create(
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
  Future<appwriteModel.User?> getCurrentUser() async {
    try {
      return await _appwriteAccount.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> getCurrentUserDetails(String id) async {
    try {
      final appwriteModel.Document document = await _appwriteDB.getDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: id,
      );
      return User.fromMap(document.data);
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
}
