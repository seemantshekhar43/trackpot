class FinanceUtils {
  const FinanceUtils._();

  static String formatAmount(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
}
