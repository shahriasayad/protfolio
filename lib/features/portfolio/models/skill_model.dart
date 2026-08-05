import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final double proficiency; // 0.0 to 1.0
  final String category; // 'Frontend', 'Backend', 'Tools', etc.
  final IconData? icon;
  final String? iconPath; // Path to icon image asset.
  Color? _cachedColor; // Cached dominant color from icon

  SkillModel({
    required this.name,
    required this.proficiency,
    required this.category,
    this.icon,
    this.iconPath,
  });

  // Getter for cached color
  Color? get cachedColor => _cachedColor;

  // Set cached color
  void setCachedColor(Color color) {
    _cachedColor = color;
  }
}
