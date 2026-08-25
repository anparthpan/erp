import 'package:flutter/material.dart';

class StatData {
  const StatData({
    required this.title,
    required this.value,
    required this.foot,
    required this.trend,
    required this.positive,
    required this.icon,
    required this.color,
    required this.softColor,
    required this.points,
  });

  final String title;
  final String value;
  final String foot;
  final String trend;
  final bool positive;
  final IconData icon;
  final Color color;
  final Color softColor;
  final List<double> points;
}
