import '../../../../core/common/models/user_model.dart';
import '../../../../core/constants/group_member_role.dart';
import '../../domain/entities/group_member.dart';

class GroupMemberModel {
  final String id;
  final String userId;
  final String groupId;
  final GroupMemberRole role;
  final DateTime joinedAt;
  final UserModel user; // Populated through relationship

  const GroupMemberModel({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.role,
    required this.joinedAt,
    required this.user,
  });

  factory GroupMemberModel.fromMap(Map<String, dynamic> json) {
    return GroupMemberModel(
      id: json['\$id'],
      userId: json['user']['\$id'],
      groupId: '',
      role: GroupMemberRole.fromMap(json['role'] as String),
      joinedAt: DateTime.parse(json['joinedAt']),
      user: UserModel.fromMap(json['user']),
    );
  }

  Map<String, dynamic> toMap() => {
        'user': userId,
        'group': groupId,
        'role': role.name,
        'joinedAt': joinedAt.toIso8601String(),
      };

  GroupMember toEntity() {
    return GroupMember(
        id: id,
        user: user.toEntity(),
        groupId: groupId,
        role: role,
        joinedAt: joinedAt);
  }

  factory GroupMemberModel.fromEntity(GroupMember groupMember) {
    return GroupMemberModel(
        id: groupMember.id,
        user: UserModel.fromEntity(groupMember.user),
        userId: groupMember.user.id,
        groupId: groupMember.groupId,
        role: groupMember.role,
        joinedAt: groupMember.joinedAt);
  }
}
