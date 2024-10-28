import 'package:flutter/material.dart';

import '../styles/sizes.dart';

class BottomSheetItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const BottomSheetItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(KSizes.lg),
        child: Container(
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
          ),
          child: Column(
            children: [
              IconButton.filled(
                onPressed: () {},
                style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                padding: const EdgeInsets.all(KSizes.smd),
                icon: Icon(
                  icon,
                  size: KSizes.iconLg,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: KSizes.smd),
              Text(label, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
