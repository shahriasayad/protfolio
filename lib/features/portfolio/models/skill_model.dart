import 'package:flutter/material.dart';

/// Represents a technical skill, proficiency score (0.0 to 1.0), and category.
class SkillModel {
  final String name;
  final double proficiency;
  final String category;
  final IconData? icon;
  final String? iconPath;

  const SkillModel({
    required this.name,
    required this.proficiency,
    required this.category,
    this.icon,
    this.iconPath,
  });

  String get tierLabel {
    if (proficiency >= 0.88) return 'Core';
    if (proficiency >= 0.75) return 'Proficient';
    return 'Working';
  }
}
