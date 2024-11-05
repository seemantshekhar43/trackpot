import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/styles/sizes.dart';
import '../../../../core/utils/finance_utils.dart';
import '../../domain/entities/group_summary.dart';
import 'group_avatar.dart';

class GroupTile extends StatefulWidget {
  final GroupSummary group;

  const GroupTile({
    super.key,
    required this.group,
  });

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              imageId: widget.group.groupPic,
              category: widget.group.category,
            ),
            const SizedBox(width: KSizes.smd),
            // Group Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.group.name,
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
                        FinanceUtils.formatAmount(widget.group.userBalance),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: FinanceUtils.getBalanceColor(
                                  widget.group.userBalance),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  if (widget.group.latestExpense != null) ...[
                    const SizedBox(height: KSizes.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.group.latestExpense!.paidBy.username} paid '
                            '\$${widget.group.latestExpense!.amount.toStringAsFixed(2)} for '
                            '${widget.group.latestExpense!.description}',
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
                          timeago.format(widget.group.latestExpense!.createdAt),
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
