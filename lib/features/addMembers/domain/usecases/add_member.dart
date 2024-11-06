import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;
import '../../../dashboard/domain/repository/group_repository.dart';

class AddMember implements UseCase<group_entity.Group, AddMemberParams> {
  final GroupRepository repository;

  AddMember(this.repository);

  @override
  Future<Either<Failure, group_entity.Group>> call(AddMemberParams params) {
    return repository.addMember(params.group);
  }
}

class AddMemberParams {
  final group_entity.Group group;

  AddMemberParams({required this.group});
}
