import '../../../../core/common/entities/user.dart';
import 'group_member.dart';

class Group {
  final String id;
  final String name;
  final String? category;
  final String? groupPic;
  final String currency;
  final DateTime createdAt;
  final User createdBy;
  final List<GroupMember> members;
  final List<String> memberIds;

  const Group({
    required this.id,
    required this.name,
    this.category,
    this.groupPic,
    required this.currency,
    required this.createdAt,
    required this.createdBy,
    required this.members,
    required this.memberIds,
  });

  Group copyWith({
    String? id,
    String? name,
    String? category,
    String? groupPic,
    String? currency,
    DateTime? createdAt,
    User? createdBy,
    List<GroupMember>? members,
    List<String>? memberIds,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      groupPic: groupPic ?? this.groupPic,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? List.from(this.members),
      memberIds: memberIds ?? List.from(this.memberIds),
    );
  }
}