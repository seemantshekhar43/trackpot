import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String icon;
  final String colorLight;
  final String colorDark;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.colorLight,
    required this.colorDark,
  });

  Category copyWith({
    String? id,
    String? name,
    String? icon,
    String? colorLight,
    String? colorDark,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      colorLight: colorLight ?? this.colorLight,
      colorDark: colorDark ?? this.colorDark,
    );
  }

  Color getColor(bool isDarkMode) {
    return isDarkMode
        ? _hexToColor(colorDark)
        : _hexToColor(colorLight);
  }


  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, icon: $icon, colorLight: $colorLight, colorDark: $colorDark)';
  }
}