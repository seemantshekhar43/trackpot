import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      color: Theme.of(context)
          .dividerColor
          .withOpacity(0.1),
    );
  }
}
