import 'package:flutter/material.dart';

class MembersListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget leadingWidget;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDense;
  final Color? tileColor;
  final bool isSelected;
  final TextStyle? titleTextStyle;
  const MembersListItem(
      {super.key,
      required this.title,
      this.subtitle,
      this.trailing,
        this.titleTextStyle,
      required this.leadingWidget,
      this.isDense = false,
      this.isSelected = false,
      this.tileColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: isDense,
      leading: leadingWidget,
      title: Text(title, style: titleTextStyle,),
      trailing: trailing,
      tileColor: tileColor,
      selected: isSelected,
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: onTap,
    );
  }
}
