import 'package:flutter/material.dart';

import '../constants/profile_constants.dart';
import '../styles/sizes.dart';

class CurrencyInputDropDownField extends StatelessWidget {
  final String labelText;
  final String? value;
  final void Function(String? value) onChanged;

  const CurrencyInputDropDownField({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          labelText: 'Default Currency',
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(KSizes.md),
          ),
          filled: true,
          fillColor:
              Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.4)),
      value: value,
      menuMaxHeight: MediaQuery.sizeOf(context).height * 0.3,
      onChanged: onChanged,
      items: ProfileConstants.currencyMap.entries
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
    );
  }
}
