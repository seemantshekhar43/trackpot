import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/styles/sizes.dart';
import '../../domain/entities/group_summary.dart';
import 'group_avatar.dart';

class GroupTile extends StatelessWidget {
  final GroupSummary group;

  const GroupTile({
    super.key,
    required this.group,
  });

  String _formatBalance(double balance) {
    final isPositive = balance >= 0;
    return '${isPositive ? '+' : ''}\$${balance.abs().toStringAsFixed(2)}';
  }

  Color _getBalanceColor(BuildContext context, double balance) {
    return balance >= 0 ? Colors.green[600]! : Colors.red[600]!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KSizes.md,
          vertical: KSizes.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group Icon
            GroupAvatar(
              imageId: group.groupPic,
              category: group.category,
            ),
            const SizedBox(width: KSizes.smd),
            // Group Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: KSizes.xs),
                  Row(
                    children: [
                      Text(
                        'My Balance:',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(width: KSizes.xs),
                      Text(
                        _formatBalance(group.userBalance),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color:
                                  _getBalanceColor(context, group.userBalance),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  if (group.latestExpense != null) ...[
                    const SizedBox(height: KSizes.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${group.latestExpense!.paidBy.username} paid '
                            '\$${group.latestExpense!.amount.toStringAsFixed(2)} for '
                            '${group.latestExpense!.description}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: KSizes.sm),
                        Text(
                          timeago.format(group.latestExpense!.createdAt),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
