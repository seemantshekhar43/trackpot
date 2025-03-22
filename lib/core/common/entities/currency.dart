class Currency {
  final String id;
  final String code;
  final String unit;

  Currency({
    required this.id,
    required this.code,
    required this.unit,
  });

  Currency copyWith({
    String? id,
    String? code,
    String? unit,
  }) {
    return Currency(
      id: id ?? this.id,
      code: code ?? this.code,
      unit: unit ?? this.unit,
    );
  }

  @override
  String toString() {
    return 'Currency(id: $id, code: $code, unit: $unit)';
  }
}