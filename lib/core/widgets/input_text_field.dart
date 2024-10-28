import 'package:flutter/material.dart';

import '../styles/sizes.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isObscureText;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const InputTextField({
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
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.3),
        labelText: labelText,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
      obscureText: isObscureText,
    );
  }
}
