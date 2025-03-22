import 'package:flutter/material.dart';
import '../../../../core/styles/sizes.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;

class TotalsTab extends StatelessWidget {
  final group_entity.Group group;

  const TotalsTab({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.pie_chart,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: KSizes.md),
          Text(
            'Expense Breakdown',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: KSizes.sm),
          Text(
            'View expense totals by category',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: KSizes.lg),
          // We'll implement the actual category cards later
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  child: const Icon(Icons.restaurant),
                ),
                title: const Text('Food & Drinks'),
                trailing: const Text('\$207.85'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}