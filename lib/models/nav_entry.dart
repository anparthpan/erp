import 'package:flutter/material.dart';

class NavEntry {
  const NavEntry({
    required this.label,
    required this.icon,
    this.badge,
  });

  final String label;
  final IconData icon;
  final String? badge;
}
