import 'user.dart';

class Share {
  final String id;
  final User user;
  final double paidAmount;
  final double owedAmount;
  final double shareQuantity;

  Share({
    required this.id,
    required this.user,
    required this.paidAmount,
    required this.owedAmount,
    required this.shareQuantity,
  });

  Share copyWith({
    String? id,
    User? user,
    double? paidAmount,
    double? owedAmount,
    double? shareQuantity,
  }) {
    return Share(
      id: id ?? this.id,
      user: user ?? this.user,
      paidAmount: paidAmount ?? this.paidAmount,
      owedAmount: owedAmount ?? this.owedAmount,
      shareQuantity: shareQuantity ?? this.shareQuantity,
    );
  }

  // Calculate if this share is positive (user is owed money)
  bool isPositive() {
    return paidAmount > owedAmount;
  }

  // Calculate the balance for this share
  double getBalance() {
    return paidAmount - owedAmount;
  }

  @override
  String toString() {
    return 'Share(id: $id, user: $user, paidAmount: $paidAmount, owedAmount: $owedAmount, shareQuantity: $shareQuantity)';
  }
}