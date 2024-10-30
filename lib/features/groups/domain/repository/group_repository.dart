import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../entities/group.dart' as group_entity;
import '../entities/group_summary.dart';

abstract class GroupRepository {
  Future<Either<Failure, List<GroupSummary>>> getUserGroups(String userId);
  Future<Either<Failure, group_entity.Group>> createGroup(
      group_entity.Group group);
  Future<Either<Failure, double>> getUserTotalBalance(String userId);
  Future<Either<Failure, Map<String, double>>> getUserBalanceStats(
      String userId);
}
