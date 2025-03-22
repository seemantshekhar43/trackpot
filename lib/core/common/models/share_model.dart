import '../entities/share.dart';
import 'user_model.dart';

class ShareModel {
  final String id;
  final double paidAmount;
  final double owedAmount;
  final double shareQuantity;
  final UserModel user;

  ShareModel({
    required this.id,
    required this.paidAmount,
    required this.owedAmount,
    required this.shareQuantity,
    required this.user,
  });

  factory ShareModel.fromMap(Map<String, dynamic> map) {
    return ShareModel(
      id: map['\$id'] ?? '',
      paidAmount: (map['paidAmount'] is int)
          ? (map['paidAmount'] as int).toDouble()
          : (map['paidAmount'] as num? ?? 0).toDouble(),
      owedAmount: (map['owedAmount'] is int)
          ? (map['owedAmount'] as int).toDouble()
          : (map['owedAmount'] as num? ?? 0).toDouble(),
      shareQuantity: map['shareQuantity'] as double? ?? 1,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'paidAmount': paidAmount,
      'owedAmount': owedAmount,
      'shareQuantity': shareQuantity,
    };
  }

  Share toEntity() {

    return Share(
      id: id,
      user: user.toEntity(),
      paidAmount: paidAmount,
      owedAmount: owedAmount,
      shareQuantity: shareQuantity,
    );
  }

  factory ShareModel.fromEntity(Share share) {
    return ShareModel(
      id: share.id,
      paidAmount: share.paidAmount,
      owedAmount: share.owedAmount,
      shareQuantity: share.shareQuantity,
      user: UserModel.fromEntity(share.user),
    );
  }
}