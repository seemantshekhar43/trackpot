import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/group_summary.dart';
import '../repository/group_repository.dart';

class WatchUserGroups
    implements UseCase<Stream<List<GroupSummary>>, WatchUserGroupsParams> {
  final GroupRepository repository;

  WatchUserGroups(this.repository);

  @override
  Future<Either<Failure, Stream<List<GroupSummary>>>> call(
      WatchUserGroupsParams params) {
    return repository.watchUserGroups(params.id);
  }
}

class WatchUserGroupsParams {
  final String id;

  WatchUserGroupsParams({
    required this.id,
  });
}
