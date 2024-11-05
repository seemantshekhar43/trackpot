import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String label;
  const SectionHeading({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
