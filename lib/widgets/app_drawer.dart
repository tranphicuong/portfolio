import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/nav_items.dart';
import 'app_logo.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.location});

  
  final String location;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
              child: AppLogo(),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  for (final item in navItems)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: ListTile(
                        leading: Icon(item.icon),
                        title: Text(item.label),
                        selected: item.path == location,
                        selectedColor: scheme.primary,
                        selectedTileColor: scheme.primary.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // đóng Drawer
                          context.go(item.path);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
