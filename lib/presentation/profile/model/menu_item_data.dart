import 'package:flutter/material.dart';

class MenuItemData {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  MenuItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}