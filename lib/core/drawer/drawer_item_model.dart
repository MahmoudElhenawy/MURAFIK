import 'package:flutter/material.dart';

class DrawerItemModel {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool isDanger;

  DrawerItemModel({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.isDanger = false,
  });
}
