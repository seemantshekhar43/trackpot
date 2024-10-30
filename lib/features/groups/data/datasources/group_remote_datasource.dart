import 'dart:io';
import 'package:appwrite/appwrite.dart';

import '../../../../core/constants/appwrite_constants.dart';
import '../../../../core/exception/server_exception.dart';
import '../../../../core/secrets/app_secrets.dart';

abstract class GroupRemoteDataSource {
  Future<List<Map<String, dynamic>>> getUserGroups(String userId);
  Future<Map<String, dynamic>> createGroup(Map<String, dynamic> groupData);
  Future<String> uploadGroupPicture(File picture);
  Future<List<Map<String, dynamic>>> getGroupExpenses(String groupId);
  Future<Map<String, dynamic>> getUserBalanceStats(String userId);
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final Databases _db;
  final Storage _storage;

  GroupRemoteDataSourceImpl(this._db, this._storage);
  @override
  Future<Map<String, dynamic>> createGroup(
      Map<String, dynamic> groupData) async {
    try {
      final result = await _db.createDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupsCollection,
        documentId: ID.unique(),
        data: groupData,
      );

      return result.data;
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getGroupExpenses(String groupId) {
    // TODO: implement getGroupExpenses
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getUserBalanceStats(String userId) {
    // TODO: implement getUserBalanceStats
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getUserGroups(String userId) {
    // TODO: implement getUserGroups
    throw UnimplementedError();
  }

  @override
  Future<String> uploadGroupPicture(File picture) async {
    try {
      final uploadResult = await _storage.createFile(
        bucketId: AppwriteConstants.groupPicBucket,
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
