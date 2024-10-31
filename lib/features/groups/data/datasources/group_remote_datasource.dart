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

  Stream<List<Map<String, dynamic>>> watchUserGroups(String userId);
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final Databases _db;
  final Storage _storage;
  final Realtime _realtime;

  GroupRemoteDataSourceImpl(this._db, this._storage, this._realtime);
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
  Future<List<Map<String, dynamic>>> getUserGroups(String userId) async {
    try {
      final result = await _db.listDocuments(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupsCollection,
        queries: [
          Query.contains('memberIds', userId),
        ],
      );
      return result.documents.map((document) => document.data).toList();
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> watchUserGroups(String userId) {
    // Subscribe to both groups and expenses collections
    final groupsSubscription = _realtime.subscribe([
      'databases.${AppSecrets.databaseId}.collections.${AppwriteConstants.groupsCollection}.documents'
    ]);

    return groupsSubscription.stream.asyncMap((_) => getUserGroups(userId));
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
