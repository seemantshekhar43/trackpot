import 'package:flutter/material.dart';

import '../../../../core/styles/sizes.dart';

class ProfileInputTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isObscureText;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const ProfileInputTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isObscureText = false,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KSizes.md, vertical: KSizes.sm),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.onInverseSurface,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
          ),
        ),
        onSaved: onSaved,
        validator: validator,
        obscureText: isObscureText,
      ),
    );
  }
}
