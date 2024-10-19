import 'package:flutter/material.dart';

import '../../../../core/styles/sizes.dart';

class AuthField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isObscureText;
  const AuthField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onInverseSurface,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$labelText is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}