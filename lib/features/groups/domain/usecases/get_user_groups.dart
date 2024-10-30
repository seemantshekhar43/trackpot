import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/group_summary.dart';
import '../repository/group_repository.dart';

class GetUserGroups
    implements UseCase<List<GroupSummary>, GetUserGroupsParams> {
  final GroupRepository repository;

  GetUserGroups(this.repository);

  @override
  Future<Either<Failure, List<GroupSummary>>> call(GetUserGroupsParams params) {
    return repository.getUserGroups(params.id);
  }
}

class GetUserGroupsParams {
  final String id;

  GetUserGroupsParams({
    required this.id,
  });
}
