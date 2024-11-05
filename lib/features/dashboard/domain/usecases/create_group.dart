import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/group.dart' as group_entity;
import '../repository/group_repository.dart';

class CreateGroup implements UseCase<group_entity.Group, group_entity.Group> {
  final GroupRepository repository;

  CreateGroup(this.repository);

  @override
  Future<Either<Failure, group_entity.Group>> call(group_entity.Group group) {
    return repository.createGroup(group);
  }
}
