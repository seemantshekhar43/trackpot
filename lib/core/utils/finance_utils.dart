import 'package:flutter/material.dart';

class FinanceUtils {
  const FinanceUtils._();

  static String formatAmount(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static Color getBalanceColor(double balance) {
    return balance >= 0 ? Colors.green[600]! : Colors.red[600]!;
  }
}
