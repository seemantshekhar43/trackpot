import 'dart:io';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/group_member_role.dart';
import '../../../../core/exception/failure.dart';
import '../../../../core/exception/server_exception.dart';
import '../../domain/entities/group_summary.dart';
import '../../domain/entities/group.dart' as group_entity;
import '../../domain/repository/group_repository.dart';
import '../datasources/group_remote_datasource.dart';
import '../models/group_member_model.dart';
import '../models/group_model.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource groupRemoteDataSource;

  GroupRepositoryImpl(this.groupRemoteDataSource);

  @override
  Future<Either<Failure, group_entity.Group>> createGroup(
      group_entity.Group group) async {
    try {
      String? groupPicId;
      if (group.groupPic != null) {
        groupPicId = await groupRemoteDataSource
            .uploadGroupPicture(File(group.groupPic!));
      }

      final groupData = GroupModel.fromEntity(group).toMap();
      if (groupPicId != null) {
        groupData['groupPic'] = groupPicId;
      }

      //add admin group member
      final String createBy = groupData['createdBy'];
      final GroupMemberModel member = GroupMemberModel(
          id: '',
          userId: createBy,
          groupId: '',
          role: GroupMemberRole.admin,
          joinedAt: DateTime.now());
      groupData['members'] = [member.toMap()];
      final result = await groupRemoteDataSource.createGroup(groupData);
      return right(GroupModel.fromMap(result));
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

  @override
  Future<Either<Failure, List<GroupSummary>>> getUserGroups(String userId) {
    // TODO: implement getUserGroups
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, double>> getUserTotalBalance(String userId) {
    // TODO: implement getUserTotalBalance
    throw UnimplementedError();
  }
}
