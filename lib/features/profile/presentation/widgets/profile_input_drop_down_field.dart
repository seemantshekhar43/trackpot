import 'package:flutter/material.dart';

import '../../../../core/styles/sizes.dart';

class ProfileInputDropDownField extends StatelessWidget {
  final String labelText;
  final String value;
  final Map<String, String> items;
  final void Function(String? value) onChanged;

  const ProfileInputDropDownField({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.sm),
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.onInverseSurface,
          contentPadding: const EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.md),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(KSizes.md),
          ),
        ),
        isEmpty: value.isEmpty,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            isDense: true,
            value: value,
            menuMaxHeight: MediaQuery.sizeOf(context).height * 0.3,
            onChanged: onChanged,
            items: items.entries
                .map((MapEntry<String, String> entry) => DropdownMenuItem(
              value: entry.key,
              child: Text(entry.key),
            ))
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a currency';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}