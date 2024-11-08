import 'dart:io';
import 'package:appwrite/appwrite.dart';

import '../../../../core/constants/appwrite_constants.dart';
import '../../../../core/exception/server_exception.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../models/group_member_model.dart';
import '../models/group_model.dart';

abstract class GroupRemoteDataSource {
  Future<List<GroupModel>> getUserGroups(String userId);

  Future<GroupModel> createGroup(GroupModel group);
  Future<void> deleteGroup(String groupId);
  Future<void> deleteGroupMember(String groupId);

  Future<String> uploadGroupPicture(File picture);
  Future<void> deleteGroupPicture(String pictureId);

  Future<List<Map<String, dynamic>>> getGroupExpenses(String groupId);

  Future<Map<String, dynamic>> getUserBalanceStats(String userId);

  Stream<List<GroupModel>> watchUserGroups(String userId);
  Stream<GroupModel> watchGroupById(String groupId);
  Future<GroupModel> getGroupById(String groupId);
  Future<GroupModel> updateGroup(GroupModel group);
  Future<GroupMemberModel> updateGroupMember(GroupMemberModel groupMember);
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final Databases _db;
  final Storage _storage;
  final Realtime _realtime;

  GroupRemoteDataSourceImpl(this._db, this._storage, this._realtime);
  @override
  Future<GroupModel> createGroup(GroupModel group) async {
    try {
      final result = await _db.createDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupsCollection,
        documentId: ID.unique(),
        data: group.toMap(),
      );

      return GroupModel.fromMap(result.data);
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
  Future<List<GroupModel>> getUserGroups(String userId) async {
    try {
      final result = await _db.listDocuments(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupsCollection,
        queries: [
          Query.contains('memberIds', userId),
        ],
      );
      return result.documents
          .map((document) => GroupModel.fromMap(document.data))
          .toList();
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<GroupModel>> watchUserGroups(String userId) {
    // Subscribe to both dashboard and expenses collections
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

  @override
  Future<void> deleteGroupPicture(String pictureId) async {
    try {
      await _storage.deleteFile(
        bucketId: AppwriteConstants.groupPicBucket,
        fileId: pictureId,
      );

      return;
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<GroupModel> getGroupById(String groupId) async {
    try {
      final result = await _db.getDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupsCollection,
        documentId: groupId,
      );
      return GroupModel.fromMap(result.data);
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<GroupModel> updateGroup(GroupModel group) async {
    try {
      final result = await _db.updateDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupsCollection,
        documentId: group.id,
        data: group.toMap(),
      );

      return GroupModel.fromMap(result.data);
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<GroupModel> watchGroupById(String groupId) {
    // subscribe to a group
    final groupSubscription = _realtime.subscribe([
      'databases.${AppSecrets.databaseId}.collections.${AppwriteConstants.groupsCollection}.documents.$groupId'
    ]);
    // Update this to not call getGroupById rather parse event data to get latest group
    return groupSubscription.stream.asyncMap((_) => getGroupById(groupId));
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    try {
      await _db.deleteDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupsCollection,
        documentId: groupId,
      );

      return;
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteGroupMember(String memberId) async {
    try {
      await _db.deleteDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupMembersCollection,
        documentId: memberId,
      );

      return;
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<GroupMemberModel> updateGroupMember(GroupMemberModel groupMember) async {
    try {
      final result = await _db.updateDocument(
        databaseId: AppSecrets.databaseId,
        collectionId: AppwriteConstants.groupMembersCollection,
        documentId: groupMember.id,
        data: groupMember.toMap(),
      );

      return GroupMemberModel.fromMap(result.data);
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
