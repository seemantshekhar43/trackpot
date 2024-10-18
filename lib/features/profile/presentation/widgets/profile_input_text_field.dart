import 'package:flutter/material.dart';
import 'package:trackpot/core/styles/sizes.dart';

class ProfileInputTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isObscureText;
  const ProfileInputTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.sm),
      child: TextFormField(
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
      ),
    );
  }
}
