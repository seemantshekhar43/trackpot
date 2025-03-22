import '../entities/currency.dart';

class CurrencyModel {
  final String id;
  final String code;
  final String unit;

  CurrencyModel({
    required this.id,
    required this.code,
    required this.unit,
  });

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      id: map['\$id'] ?? '',
      code: map['code'] ?? '',
      unit: map['unit'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'unit': unit,
    };
  }

  Currency toEntity() {
    return Currency(
      id: id,
      code: code,
      unit: unit,
    );
  }

  factory CurrencyModel.fromEntity(Currency currency) {
    return CurrencyModel(
      id: currency.id,
      code: currency.code,
      unit: currency.unit,
    );
  }
}