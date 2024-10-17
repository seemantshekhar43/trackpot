import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const SettingsListItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
