import 'package:flutter/material.dart';

class TaskData {
  const TaskData({
    required this.title,
    required this.detail,
    required this.action,
    required this.icon,
    required this.color,
    required this.background,
  });

  final String title;
  final String detail;
  final String action;
  final IconData icon;
  final Color color;
  final Color background;
}
