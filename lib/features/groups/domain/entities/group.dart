import '../../../../core/common/entities/user.dart';

class Group {
  final String id;
  final String name;
  final String? category;
  final String? groupPic;
  final String currency;
  final DateTime createdAt;
  final User createdBy;
  final List<User> members;

  const Group({
    required this.id,
    required this.name,
    this.category,
    this.groupPic,
    required this.currency,
    required this.createdAt,
    required this.createdBy,
    required this.members,
  });
}