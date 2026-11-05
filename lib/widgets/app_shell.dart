import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/nav_items.dart';
import '../utils/responsive.dart';
import 'app_drawer.dart';
import 'app_logo.dart';
import 'nav_link.dart';
import 'theme_toggle_button.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < Breakpoints.compactNav;
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: compact ? 0 : padding,
        title: const AppLogo(),
        actions: [
          if (!compact)
            for (final item in navItems)
              NavLink(item: item, selected: item.path == location),
          const SizedBox(width: 4),
          const ThemeToggleButton(),
          SizedBox(width: compact ? 8 : padding),
        ],
      ),
      drawer: compact ? AppDrawer(location: location) : null,
      body: child,
    );
  }
}
