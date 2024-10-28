import 'package:flutter/material.dart';
import 'package:trackpot/core/styles/sizes.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:KSizes.md),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: Theme.of(context).textTheme.bodyLarge
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$1,248.00',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Owed and Owe Section
            const Row(
              children: [
                Expanded(
                  child: _BalanceInfoCard(
                    isPositive: true,
                    label: 'You are owed',
                    amount: '\$2,360.00',
                  ),
                ),
                SizedBox(width: KSizes.smd),
                Expanded(
                  child: _BalanceInfoCard(
                    isPositive: false,
                    label: 'You owe',
                    amount: '\$1,112.00',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceInfoCard extends StatelessWidget {
  final bool isPositive;
  final String label;
  final String amount;

  const _BalanceInfoCard({
    required this.isPositive,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isPositive
                ? Icons.arrow_upward_rounded
                : Icons.arrow_downward_rounded,
            color: color[700],
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color[700]
                ),
              ),
              Text(
                amount,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}