import 'package:flutter/material.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/list_divider.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;

class ExpenseTab extends StatelessWidget {
  final group_entity.Group group;

  const ExpenseTab({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    // Placeholder expense data
    final mockExpenses = [
      {
        'date': 'Today',
        'items': [
          {
            'id': '1',
            'title': 'Dinner at Restaurant',
            'paidBy': 'You',
            'amount': 120.50,
            'status': 'paid',
          },
          {
            'id': '2',
            'title': 'Movie tickets',
            'paidBy': 'Alex',
            'amount': 45.00,
            'status': 'owe',
          },
        ],
      },
      {
        'date': 'Yesterday',
        'items': [
          {
            'id': '3',
            'title': 'Groceries',
            'paidBy': 'You',
            'amount': 87.35,
            'status': 'paid',
          },
        ],
      },
    ];

    return ListView.builder(
      itemCount: mockExpenses.length,
      itemBuilder: (context, index) {
        final expenseGroup = mockExpenses[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: KSizes.md,
                vertical: KSizes.sm,
              ),
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              child: Text(
                expenseGroup['date'] as String,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Expense items
            ...(expenseGroup['items'] as List).map((expense) {
              final isPositive = expense['status'] == 'paid';
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
                      ),
                      child: const Icon(Icons.receipt),
                    ),
                    title: Text(expense['title'] as String),
                    subtitle: Text(
                      isPositive
                          ? 'You paid'
                          : 'You owe ${expense['paidBy']}',
                    ),
                    trailing: Text(
                      '${isPositive ? '+' : '-'}\$${(expense['amount'] as double).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const ListDivider(),
                ],
              );
            }),
          ],
        );
      },
    );
  }
}