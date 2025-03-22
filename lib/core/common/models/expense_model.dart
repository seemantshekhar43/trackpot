
import '../../../../core/common/models/share_model.dart';
import '../../../../core/common/models/category_model.dart';
import '../../../../core/common/models/currency_model.dart';
import '../../../../core/common/models/user_model.dart';
import '../../../features/dashboard/data/models/group_model.dart';
import '../entities/expense.dart';


class ExpenseModel {
  final String id;
  final String title;
  final String? description;
  final SplitType splitType;
  final double amount;
  final String? bill;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdById;
  final String updatedById;
  final String categoryId;
  final String currencyId;
  final String groupId;
  final UserModel? createdByModel;
  final UserModel? updatedByModel;
  final CategoryModel? categoryModel;
  final CurrencyModel? currencyModel;
  final GroupModel? groupModel;
  final List<ShareModel> shares;

  ExpenseModel({
    required this.id,
    required this.title,
    this.description,
    required this.splitType,
    required this.amount,
    this.bill,
    required this.createdAt,
    required this.updatedAt,
    required this.createdById,
    required this.updatedById,
    required this.categoryId,
    required this.currencyId,
    required this.groupId,
    this.createdByModel,
    this.updatedByModel,
    this.categoryModel,
    this.currencyModel,
    this.groupModel,
    this.shares = const [],
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    // Parse relationships if they exist
    UserModel? createdByModel;
    UserModel? updatedByModel;
    CategoryModel? categoryModel;
    CurrencyModel? currencyModel;
    GroupModel? groupModel;
    List<ShareModel> shares = [];

    if (map['createdBy'] is Map<String, dynamic>) {
      createdByModel = UserModel.fromMap(map['createdBy']);
    }

    if (map['updatedBy'] is Map<String, dynamic>) {
      updatedByModel = UserModel.fromMap(map['updatedBy']);
    }

    if (map['category'] is Map<String, dynamic>) {
      categoryModel = CategoryModel.fromMap(map['category']);
    }

    if (map['currency'] is Map<String, dynamic>) {
      currencyModel = CurrencyModel.fromMap(map['currency']);
    }

    if (map['group'] is Map<String, dynamic>) {
      groupModel = GroupModel.fromMap(map['group']);
    }

    if (map['shares'] is List) {
      shares = (map['shares'] as List)
          .map((share) => ShareModel.fromMap(share))
          .toList();
    }

    return ExpenseModel(
      id: map['\$id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      splitType: SplitType.fromMap(map['splitType'] ?? 'EQUAL'),
      amount: (map['amount'] is int)
          ? (map['amount'] as int).toDouble()
          : (map['amount'] as num? ?? 0).toDouble(),
      bill: map['bill'],
      createdAt: DateTime.parse(map['\$createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['\$updatedAt'] ?? DateTime.now().toIso8601String()),
      createdById: (map['createdBy'] is Map) ? map['createdBy']['\$id'] : (map['createdBy'] ?? ''),
      updatedById: (map['updatedBy'] is Map) ? map['updatedBy']['\$id'] : (map['updatedBy'] ?? ''),
      categoryId: (map['category'] is Map) ? map['category']['\$id'] : (map['category'] ?? ''),
      currencyId: (map['currency'] is Map) ? map['currency']['\$id'] : (map['currency'] ?? ''),
      groupId: (map['group'] is Map) ? map['group']['\$id'] : (map['group'] ?? ''),
      createdByModel: createdByModel,
      updatedByModel: updatedByModel,
      categoryModel: categoryModel,
      currencyModel: currencyModel,
      groupModel: groupModel,
      shares: shares,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'splitType': splitType.toMap(),
      'amount': amount,
      'bill': bill,
      'createdBy': createdById,
      'updatedBy': updatedById,
      'category': categoryId,
      'currency': currencyId,
      'group': groupId,
    };
  }

  Expense toEntity() {
    if (createdByModel == null ||
        updatedByModel == null ||
        categoryModel == null ||
        currencyModel == null ||
        groupModel == null) {
      throw Exception('Cannot convert to entity: required relationship data is missing');
    }

    return Expense(
      id: id,
      title: title,
      description: description,
      splitType: splitType,
      amount: amount,
      bill: bill,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdByModel!.toEntity(),
      updatedBy: updatedByModel!.toEntity(),
      category: categoryModel!.toEntity(),
      currency: currencyModel!.toEntity(),
      group: groupModel!.toEntity(),
      shares: shares.map((share) => share.toEntity()).toList(),
    );
  }

  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      title: expense.title,
      description: expense.description,
      splitType: expense.splitType,
      amount: expense.amount,
      bill: expense.bill,
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
      createdById: expense.createdBy.id,
      updatedById: expense.updatedBy.id,
      categoryId: expense.category.id,
      currencyId: expense.currency.id,
      groupId: expense.group.id,
      createdByModel: UserModel.fromEntity(expense.createdBy),
      updatedByModel: UserModel.fromEntity(expense.updatedBy),
      categoryModel: CategoryModel.fromEntity(expense.category),
      currencyModel: CurrencyModel.fromEntity(expense.currency),
      groupModel: GroupModel.fromEntity(expense.group),
      shares: expense.shares.map((share) => ShareModel.fromEntity(share)).toList(),
    );
  }
}