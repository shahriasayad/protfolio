import 'package:flutter/material.dart';

class PortfolioStatModel {
  final String value;
  final String label;
  final String detail;
  final IconData icon;
  final Color accent;

  const PortfolioStatModel({
    required this.value,
    required this.label,
    required this.detail,
    required this.icon,
    required this.accent,
  });
}
