import 'package:flutter/material.dart';

class MembersListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget leadingWidget;
  final VoidCallback onTap;
  final bool isDense;
  const MembersListItem(
      {super.key,
      required this.title,
        this.subtitle,
      required this.leadingWidget,
        this.isDense = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: isDense,
      leading: leadingWidget,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!): null,
      onTap: onTap,
    );
  }
}
