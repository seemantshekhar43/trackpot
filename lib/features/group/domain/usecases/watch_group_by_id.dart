import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;
import '../../../dashboard/domain/repository/group_repository.dart';

class WatchGroupById
    implements StreamUseCase<group_entity.Group, WatchGroupByIdParams> {
  final GroupRepository repository;

  WatchGroupById(this.repository);

  @override
  Stream<Either<Failure, group_entity.Group>> call(
      WatchGroupByIdParams params) {
    return repository.watchGroupById(params.groupId);
  }
}

class WatchGroupByIdParams {
  final String groupId;

  WatchGroupByIdParams({
    required this.groupId,
  });
}
