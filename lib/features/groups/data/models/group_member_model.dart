import '../../../../core/common/models/user_model.dart';
import '../../../../core/constants/group_member_role.dart';

class GroupMemberModel {
  final String id;
  final String userId;
  final String groupId;
  final GroupMemberRole role;
  final DateTime joinedAt;
  final UserModel? user; // Populated through relationship

  const GroupMemberModel({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.role,
    required this.joinedAt,
    this.user,
  });

  factory GroupMemberModel.fromMap(Map<String, dynamic> json) {
    return GroupMemberModel(
      id: json['\$id'],
      userId: json['userId'],
      groupId: json['groupId'],
      role: GroupMemberRole.values.firstWhere(
            (e) => e.toString() == json['role'],
        orElse: () => GroupMemberRole.member,
      ),
      joinedAt: DateTime.parse(json['joinedAt']),
      user: json['user'] != null ? UserModel.fromMap(json['user']) : null,
    );
  }

  Map<String, dynamic> toMap() => {
    'user': userId,
    'group': groupId,
    'role': role.name,
    'joinedAt': joinedAt.toIso8601String(),
  };
}

