// lib/core/common/models/category_model.dart
import '../entities/category.dart';

class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final String colorLight;
  final String colorDark;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.colorLight,
    required this.colorDark,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['\$id'] ?? '',
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      colorLight: map['colorLight'] ?? '#000000',
      colorDark: map['colorDark'] ?? '#FFFFFF',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'colorLight': colorLight,
      'colorDark': colorDark,
    };
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      icon: icon,
      colorLight: colorLight,
      colorDark: colorDark,
    );
  }

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      icon: category.icon,
      colorLight: category.colorLight,
      colorDark: category.colorDark,
    );
  }
}