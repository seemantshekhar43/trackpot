import 'expense_summary.dart';
import 'group.dart';

class GroupSummary {
  final String groupId;
  final String name;
  final String? groupPic;
  final double userBalance;
  final ExpenseSummary? latestExpense;
  final String? category;

  const GroupSummary({
    required this.groupId,
    required this.name,
    this.groupPic,
    required this.userBalance,
    this.latestExpense,
    this.category,
  });

  factory GroupSummary.fromGroupEntity(Group group) {
    return GroupSummary(
        groupId: group.id,
        name: group.name,
        userBalance: 0,
        groupPic: group.groupPic ?? '',
        latestExpense: ExpenseSummary(
            description: 'Movie night',
            amount: 23,
            paidBy: group.createdBy,
            createdAt: group.createdAt),
        category: group.category);
  }
}
