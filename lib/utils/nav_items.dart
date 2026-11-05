import 'package:flutter/material.dart';

import 'constants.dart';

class NavItem {
  const NavItem({
    required this.label,
    required this.path,
    required this.icon,
  });

  final String label;
  final String path;
  final IconData icon;
}

const List<NavItem> navItems = [
  NavItem(label: 'Trang chủ', path: AppRoutes.home, icon: Icons.home_rounded),
  NavItem(label: 'Hồ sơ', path: AppRoutes.resume, icon: Icons.badge_rounded),
  NavItem(label: 'Kỹ năng', path: AppRoutes.skills, icon: Icons.bolt_rounded),
  NavItem(
    label: 'Dự án',
    path: AppRoutes.projects,
    icon: Icons.folder_special_rounded,
  ),
  NavItem(label: 'Liên hệ', path: AppRoutes.contact, icon: Icons.mail_rounded),
];
