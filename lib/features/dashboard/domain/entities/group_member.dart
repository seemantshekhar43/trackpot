import '../../../../core/common/entities/user.dart';
import '../../../../core/constants/group_member_role.dart';

class GroupMember {
  final String id;
  final String groupId;
  final User user;
  final GroupMemberRole role;
  final DateTime joinedAt;

  GroupMember({
    required this.id,
    required this.groupId,
    required this.user,
    required this.role,
    required this.joinedAt,
  });


}
