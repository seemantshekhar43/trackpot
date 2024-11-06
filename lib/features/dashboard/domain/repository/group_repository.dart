import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../entities/group.dart' as group_entity;
import '../entities/group_summary.dart';

abstract class GroupRepository {
  Stream<Either<Failure, List<GroupSummary>>> watchUserGroups(
      String userId);
  Future<Either<Failure, List<GroupSummary>>> getUserGroups(String userId);
  Future<Either<Failure, group_entity.Group>> createGroup(
      group_entity.Group group);
  Future<Either<Failure, group_entity.Group>> updateGroup(
      group_entity.Group group, String? groupPic);
  Future<Either<Failure, group_entity.Group>> addMember(
      group_entity.Group group);
  Future<Either<Failure, double>> getUserTotalBalance(String userId);
  Future<Either<Failure, Map<String, double>>> getUserBalanceStats(
      String userId);
  group_entity.Group? getGroupById(String groupId);
  Stream<Either<Failure, group_entity.Group>> watchGroupById(
      String groupId);
}
