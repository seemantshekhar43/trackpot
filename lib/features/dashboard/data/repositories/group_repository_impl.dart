import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/exception/server_exception.dart';
import '../../../../core/network/network_connection_checker.dart';
import '../../domain/entities/group.dart' as group_entity;
import '../../domain/entities/group_summary.dart';
import '../../domain/repository/group_repository.dart';
import '../datasources/group_cache_datasource.dart';
import '../datasources/group_remote_datasource.dart';
import '../models/group_model.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource groupRemoteDataSource;
  final GroupMemoryCacheDataSource groupMemoryCacheDataSource;
  final NetworkConnectionChecker networkConnectionChecker;

  GroupRepositoryImpl(
      {required this.groupRemoteDataSource,
      required this.groupMemoryCacheDataSource,
      required this.networkConnectionChecker});

  @override
  Future<Either<Failure, group_entity.Group>> createGroup(
      group_entity.Group group) async {
    try {
      String? groupPicId;
      if (group.groupPic != null) {
        groupPicId = await groupRemoteDataSource
            .uploadGroupPicture(File(group.groupPic!));
      }
      if (groupPicId != null) {
        group = group.copyWith(groupPic: groupPicId);
      }
      final groupData = GroupModel.fromEntity(group);


      //add admin group member
      // final String createBy = groupData['createdBy'];
      // final GroupMemberModel member = GroupMemberModel(
      //     id: '',
      //     userId: createBy,
      //     groupId: '',
      //     role: GroupMemberRole.admin,
      //     joinedAt: DateTime.now());
      // groupData['members'] = [member.toMap()];
      // groupData['memberIds'] = [member.userId];
      final result = await groupRemoteDataSource.createGroup(groupData);
      return right(result.toEntity());
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getUserBalanceStats(
      String userId) {
    // TODO: implement getUserBalanceStats
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, Stream<List<GroupSummary>>>> watchUserGroups(
  //     String userId) async {
  //   try {
  //     final Stream<List<GroupModel>> stream =
  //         groupRemoteDataSource.watchUserGroups(userId);
  //     final groupSummaryStream = stream.asyncMap((groupsMap) => Future.wait(
  //         groupsMap.map((group) async => group.toGroupSummaryEntity())));
  //     return right(groupSummaryStream);
  //   } on ServerException catch (e) {
  //     return left(Failure(message: e.message));
  //   }
  // }

  @override
  Future<Either<Failure, List<GroupSummary>>> getUserGroups(
      String userId) async {
    try {
      final List<GroupModel> groupsMap =
          await groupRemoteDataSource.getUserGroups(userId);
      final groupSummaries =
          groupsMap.map((group) => group.toGroupSummaryEntity()).toList();
      return right(groupSummaries);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, double>> getUserTotalBalance(String userId) {
    // TODO: implement getUserTotalBalance
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<GroupSummary>>> watchUserGroups(
      String userId) async* {
    // 1. First emit from memory cache if available
    final cachedGroups = groupMemoryCacheDataSource.getAllUserGroups();
    if (cachedGroups.isNotEmpty) {
      yield Right(
          cachedGroups.map((group) => group.toGroupSummaryEntity()).toList());
    }

    // 2. Emit from local storage
    // final localGroups = await localStorage.getAllGroups();
    // if (localGroups.isNotEmpty) {
    //   final groupMap = Map.fromEntries(
    //     localGroups.map((g) => MapEntry(g.id, g)),
    //   );
    //   // Update memory cache
    //   for (final group in localGroups) {
    //     memoryCache.cacheGroup(group);
    //   }
    //   yield Right(groupMap);
    // }

    // 3. If online, fetch and watch remote changes
    if (await networkConnectionChecker.isConnected) {
      try {
        // Initial fetch
        final remoteGroups = await groupRemoteDataSource.getUserGroups(userId);

        // Update both caches
        for (final group in remoteGroups) {
          groupMemoryCacheDataSource.cacheGroup(group);
          //await localStorage.saveGroup(group);
        }

        yield Right(
            remoteGroups.map((group) => group.toGroupSummaryEntity()).toList());

        // 4. Watch for changes
        yield* groupRemoteDataSource.watchUserGroups(userId).asyncMap((groups) {
          // Update caches with new data
          for (final group in groups) {
            groupMemoryCacheDataSource.cacheGroup(group);
            //await localStorage.saveGroup(group);
          }

          return Right<Failure, List<GroupSummary>>(
            groups.map((group) => group.toGroupSummaryEntity()).toList(),
          );
        }).handleError((error) {
          if (error is ServerException) {
            return left(Failure(message: error.message));
          }
          return left(Failure(message: error.toString()));
        });
      } on ServerException catch (e) {
        // If remote fetch fails but we have local data, keep serving it
        // if (localGroups.isNotEmpty) {
        //   yield Right(Map.fromEntries(
        //     localGroups.map((g) => MapEntry(g.id, g)),
        //   ));
        // } else {
        //   yield Left(ServerFailure(message: e.message));
        // }
        yield left(Failure(message: e.message));
      }
    } else {
      // If offline, watch local storage for changes
      // yield* localStorage.watchAllGroups().map((groups) => Right(
      //   Map.fromEntries(groups.map((g) => MapEntry(g.id, g))),
      // ));
    }
  }

  // Method to get a single group from the cached collection
  @override
  group_entity.Group? getGroupById(String groupId) {
    return groupMemoryCacheDataSource.getGroupFromCache(groupId)?.toEntity();
  }

  @override
  Stream<Either<Failure, group_entity.Group>> watchGroupById(
      String groupId) async* {
    // 1. First emit from memory cache if available
    final GroupModel? cachedGroup =
        groupMemoryCacheDataSource.getGroupFromCache(groupId);
    if (cachedGroup != null) {
      yield Right(cachedGroup.toEntity());
    }

    // 2. Emit from local storage
    // final localGroups = await localStorage.getAllGroups();
    // if (localGroups.isNotEmpty) {
    //   final groupMap = Map.fromEntries(
    //     localGroups.map((g) => MapEntry(g.id, g)),
    //   );
    //   // Update memory cache
    //   for (final group in localGroups) {
    //     memoryCache.cacheGroup(group);
    //   }
    //   yield Right(groupMap);
    // }

    // 3. If online, fetch and watch remote changes
    if (await networkConnectionChecker.isConnected) {
      try {
        // Initial fetch
        final remoteGroup = await groupRemoteDataSource.getGroupById(groupId);

        // Update both caches
        groupMemoryCacheDataSource.cacheGroup(remoteGroup);
        //await localStorage.saveGroup(remoteGroup);

        yield Right(remoteGroup.toEntity());

        // 4. Watch for changes
        yield* groupRemoteDataSource.watchGroupById(groupId).asyncMap((group) {
          // Update caches with new data

          groupMemoryCacheDataSource.cacheGroup(group);
          //await localStorage.saveGroup(group);

          return Right<Failure, group_entity.Group>(group.toEntity());
        }).handleError((error) {
          if (error is ServerException) {
            return left(Failure(message: error.message));
          }
          return left(Failure(message: error.toString()));
        });
      } on ServerException catch (e) {
        // If remote fetch fails but we have local data, keep serving it
        // if (localGroups.isNotEmpty) {
        //   yield Right(Map.fromEntries(
        //     localGroups.map((g) => MapEntry(g.id, g)),
        //   ));
        // } else {
        //   yield Left(ServerFailure(message: e.message));
        // }
        yield left(Failure(message: e.message));
      }
    } else {
      // If offline, watch local storage for changes
      // yield* localStorage.watchAllGroups().map((groups) => Right(
      //   Map.fromEntries(groups.map((g) => MapEntry(g.id, g))),
      // ));
    }
  }

  @override
  Future<Either<Failure, group_entity.Group>> updateGroup(group_entity.Group group, String? groupPic) async {
    try {
      if (groupPic != null) {
        groupPic = await groupRemoteDataSource
            .uploadGroupPicture(File(groupPic));
      }
      if (groupPic != null) {
        group = group.copyWith(groupPic: groupPic);
      }
      final groupData = GroupModel.fromEntity(group);

      final result = await groupRemoteDataSource.updateGroup(groupData);
      return right(result.toEntity());
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
  @override
  Future<Either<Failure, group_entity.Group>> addMember(group_entity.Group group) async {
    try {
      final groupData = GroupModel.fromEntity(group);
      final result = await groupRemoteDataSource.updateGroup(groupData);
      return right(result.toEntity());
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
