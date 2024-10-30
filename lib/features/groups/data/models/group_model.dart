import '../../../../core/common/entities/user.dart';
import '../../domain/entities/group.dart';

class GroupModel extends Group {
  GroupModel({
    required super.id,
    required super.name,
    super.category,
    super.groupPic,
    required super.currency,
    required super.createdAt,
    required super.createdBy,
    required super.members,
  });

  factory GroupModel.fromMap(Map<String, dynamic> json) {
    return GroupModel(
      id: json['\$id'] as String,
      name: json['name'] as String,
      category: json['category'] as String?,
      groupPic: json['groupPic'] as String?,
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: User.fromMap(json['createdBy']),
      members: [],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'category': category,
        'groupPic': groupPic,
        'currency': currency,
        'createdAt': createdAt.toIso8601String(),
        'createdBy': createdBy.id,
      };

  factory GroupModel.fromEntity(Group group) {
    return GroupModel(
      id: group.id,
      name: group.name,
      category: group.category,
      groupPic: group.groupPic,
      currency: group.currency,
      createdAt: group.createdAt,
      createdBy: group.createdBy,
      members: group.members,
    );
  }
}
