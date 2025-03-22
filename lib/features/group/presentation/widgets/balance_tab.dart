import 'package:flutter/material.dart';
import '../../../../core/styles/sizes.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;

class BalanceTab extends StatelessWidget {
  final group_entity.Group group;

  const BalanceTab({super.key, required this.group});

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
              Icons.account_balance_wallet,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: KSizes.md),
          Text(
            'Group Balances',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: KSizes.sm),
          Text(
            'See who owes who in the group',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: KSizes.lg),
          // We'll implement the actual balance cards later
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Card(
              child: ListTile(
                title: const Text('Alex'),
                subtitle: const Text('You owe \$45.00'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Handle tapping on a member balance
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}