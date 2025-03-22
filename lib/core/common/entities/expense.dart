import 'package:trackpot/core/common/entities/share.dart';

import '../../../../core/common/entities/category.dart';
import '../../../../core/common/entities/currency.dart';
import '../../../../core/common/entities/user.dart';
import '../../../features/dashboard/domain/entities/group.dart';

enum SplitType {
  EQUAL,
  EXACT,
  PERCENTAGE,
  SHARES;

  String toMap() => name;

  static SplitType fromMap(String type) {
    return SplitType.values.firstWhere(
          (e) => e.name == type,
      orElse: () => SplitType.EQUAL,
    );
  }
}

class Expense {
  final String id;
  final String title;
  final String? description;
  final SplitType splitType;
  final double amount;
  final String? bill;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User createdBy;
  final User updatedBy;
  final Category category;
  final Currency currency;
  final Group group;
  final List<Share> shares;

  Expense({
    required this.id,
    required this.title,
    this.description,
    required this.splitType,
    required this.amount,
    this.bill,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.category,
    required this.currency,
    required this.group,
    required this.shares,
  });

  Expense copyWith({
    String? id,
    String? title,
    String? description,
    SplitType? splitType,
    double? amount,
    String? bill,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? createdBy,
    User? updatedBy,
    Category? category,
    Currency? currency,
    Group? group,
    List<Share>? shares,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      splitType: splitType ?? this.splitType,
      amount: amount ?? this.amount,
      bill: bill ?? this.bill,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      category: category ?? this.category,
      currency: currency ?? this.currency,
      group: group ?? this.group,
      shares: shares ?? this.shares,
    );
  }

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, description: $description, splitType: $splitType, amount: $amount, bill: $bill, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}