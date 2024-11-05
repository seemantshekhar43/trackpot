
import 'expense_summary.dart';

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
}
