import '../../../../core/common/entities/user.dart';

class ExpenseSummary {
  final String description;
  final double amount;
  final User paidBy;
  final DateTime createdAt;

  const ExpenseSummary({
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.createdAt,
  });
}
