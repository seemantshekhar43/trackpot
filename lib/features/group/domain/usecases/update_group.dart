import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;
import '../../../dashboard/domain/repository/group_repository.dart';

class UpdateGroup implements UseCase<group_entity.Group, UpdateGroupParams> {
  final GroupRepository repository;

  UpdateGroup(this.repository);

  @override
  Future<Either<Failure, group_entity.Group>> call(UpdateGroupParams params) {
    return repository.updateGroup(params.group, params.groupPic);
  }
}

class UpdateGroupParams {
  final group_entity.Group group;
  final String? groupPic;

  UpdateGroupParams({required this.group, this.groupPic});
}
