import 'package:flutter/material.dart';

class ActionItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  ActionItem({required this.icon, required this.label, required this.onTap});
}
