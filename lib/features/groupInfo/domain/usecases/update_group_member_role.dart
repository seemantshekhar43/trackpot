import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../dashboard/domain/entities/group_member.dart';
import '../../../dashboard/domain/repository/group_repository.dart';

class UpdateGroupMemberRole
    implements UseCase<GroupMember, UpdateGroupMemberRoleParams> {
  final GroupRepository repository;

  UpdateGroupMemberRole(this.repository);

  @override
  Future<Either<Failure, GroupMember>> call(
      UpdateGroupMemberRoleParams params) {
    return repository.updateGroupMember(params.groupMember);
  }
}

class UpdateGroupMemberRoleParams {
  final GroupMember groupMember;

  UpdateGroupMemberRoleParams({required this.groupMember});
}
