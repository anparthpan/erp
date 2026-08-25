import 'package:flutter/material.dart';

class FeatureData {
  const FeatureData({
    required this.title,
    required this.detail,
    required this.icon,
    required this.color,
    required this.background,
    this.status,
    this.action,
  });

  final String title;
  final String detail;
  final IconData icon;
  final Color color;
  final Color background;
  final String? status;
  final String? action;
}
