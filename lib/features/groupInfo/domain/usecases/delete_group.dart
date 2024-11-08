import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;
import '../../../dashboard/domain/repository/group_repository.dart';

class DeleteGroup implements UseCase<void, DeleteGroupParams> {
  final GroupRepository repository;

  DeleteGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteGroupParams params) {
    return repository.deleteGroup(params.group);
  }
}

class DeleteGroupParams {
  final group_entity.Group group;

  DeleteGroupParams({required this.group});
}
