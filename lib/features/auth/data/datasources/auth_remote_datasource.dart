import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwriteModel;
import '../../../../../core/exception/server_exception.dart';

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
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Account appwriteAccount;
  AuthRemoteDataSourceImpl(this.appwriteAccount);

  @override
  Future<appwriteModel.Session> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final appwriteModel.Session session = await appwriteAccount.createEmailPasswordSession(
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
      final appwriteModel.User user = await appwriteAccount.create(
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
  Future<appwriteModel.User?> getCurrentUser() async{
    try {
      return await appwriteAccount.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
