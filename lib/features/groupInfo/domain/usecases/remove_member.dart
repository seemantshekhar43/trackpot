import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;
import '../../../dashboard/domain/entities/group_member.dart';
import '../../../dashboard/domain/repository/group_repository.dart';

class RemoveMember implements UseCase<group_entity.Group, RemoveMemberParams> {
  final GroupRepository repository;

  RemoveMember(this.repository);

  @override
  Future<Either<Failure, group_entity.Group>> call(RemoveMemberParams params) {
    return repository.removeMember(params.group, params.member);
  }
}

class RemoveMemberParams {
  final group_entity.Group group;
  final GroupMember member;

  RemoveMemberParams(this.member, {required this.group});
}
