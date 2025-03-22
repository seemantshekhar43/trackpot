import 'dart:math';

import '../../../../core/common/models/expense_model.dart';
import '../../../../core/common/models/user_model.dart';
import '../../domain/entities/expense_summary.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/group_summary.dart';
import 'group_member_model.dart';

class GroupModel {
  final String id;
  final String name;
  final String? category;
  final String? groupPic;
  final String currency;
  final DateTime createdAt;
  final UserModel createdBy;
  final List<GroupMemberModel> members;
  final List<String> memberIds;
  final List<ExpenseModel> expenses;

  GroupModel({
    required this.id,
    required this.name,
    this.category,
    this.groupPic,
    required this.currency,
    required this.createdAt,
    required this.createdBy,
    required this.members,
    required this.memberIds,
    this.expenses = const [],
  });

  factory GroupModel.fromMap(Map<String, dynamic> json) {
    List<ExpenseModel> expenses = [];

    // Parse expenses if they exist in the response
    if (json['expenses'] != null && json['expenses'] is List) {
      expenses = (json['expenses'] as List)
          .map((expense) => expense as Map<String, dynamic>)
          .map((expense) => ExpenseModel.fromMap(expense))
          .toList();
    }

    return GroupModel(
      id: json['\$id'] as String,
      name: json['name'] as String,
      category: json['category'] as String?,
      groupPic: json['groupPic'] as String?,
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: UserModel.fromMap(json['createdBy']),
      members: json['members'] != null
          ? (json['members'] as List<dynamic>)
              .map((member) => member as Map<String, dynamic>)
              .map((member) => GroupMemberModel.fromMap(member))
              .toList()
          : [],
      memberIds: json['memberIds'] != null
          ? (json['memberIds'] as List<dynamic>)
              .map((memberId) => memberId as String)
              .toList()
          : [],
      expenses: expenses,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'category': category,
        'groupPic': groupPic,
        'currency': currency,
        'createdAt': createdAt.toIso8601String(),
        'createdBy': createdBy.id,
        'memberIds': memberIds,
        'members': members.map((member) => member.toMap()).toList()
      };

  factory GroupModel.fromEntity(Group group) {
    return GroupModel(
      id: group.id,
      name: group.name,
      category: group.category,
      groupPic: group.groupPic,
      currency: group.currency,
      createdAt: group.createdAt,
      createdBy: UserModel.fromEntity(group.createdBy),
      members: group.members
          .map((member) => GroupMemberModel.fromEntity(member))
          .toList(),
      memberIds: group.memberIds,
      expenses: group.expenses
          .map((expense) => ExpenseModel.fromEntity(expense))
          .toList(),
    );
  }

  Group toEntity() {
    return Group(
      id: id,
      name: name,
      category: category,
      groupPic: groupPic,
      currency: currency,
      createdAt: createdAt,
      createdBy: createdBy.toEntity(),
      members: members.map((member) => member.toEntity()).toList(),
      memberIds: memberIds,
      expenses: expenses.map((expense) => expense.toEntity()).toList(),
    );
  }

  GroupSummary toGroupSummaryEntity() {
    return GroupSummary(
        groupId: id,
        name: name,
        userBalance: Random().nextInt(201) - 100,
        groupPic: groupPic ?? '',
        latestExpense: ExpenseSummary(
            description: 'Movie night',
            amount: 23,
            paidBy: createdBy.toEntity(),
            createdAt: createdAt),
        category: category);
  }
}
