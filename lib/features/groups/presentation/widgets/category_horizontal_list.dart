import 'package:flutter/material.dart';
import 'package:trackpot/core/constants/group_constants.dart';

import '../../../../core/styles/sizes.dart';

class CategoryHorizontalList extends StatelessWidget {
  final String? selectedCategory;
  final Function(String) onSelect;

  const CategoryHorizontalList({
    super.key,
    this.selectedCategory,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const categories = GroupConstants.categories;
    return Wrap(
      spacing: KSizes.sm,
      runSpacing: KSizes.sm,
      children: categories.map((category) {
        final isSelected = selectedCategory == category['name'];
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                category['icon'] as IconData,
                size: KSizes.iconSMd,
                color: isSelected ? Colors.white : category['color'],
              ),
              const SizedBox(width: KSizes.sm),
              Text(
                category['name'],
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: isSelected ? Colors.white : Colors.grey.shade700),
              ),
            ],
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            onSelect(category['name']);
          },
          selectedColor: category['color'],
          backgroundColor: Colors.transparent,
        );
      }).toList(),
    );
  }
}
