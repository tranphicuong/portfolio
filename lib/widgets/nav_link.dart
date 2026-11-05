import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/constants.dart';
import '../utils/nav_items.dart';


class NavLink extends StatefulWidget {
  const NavLink({super.key, required this.item, required this.selected});

  final NavItem item;
  final bool selected;

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final active = widget.selected || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Semantics(
        button: true,
        selected: widget.selected,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.go(widget.item.path),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: AppDurations.fast,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        widget.selected ? FontWeight.w800 : FontWeight.w500,
                    color: active ? scheme.primary : scheme.onSurface,
                  ),
                  child: Text(widget.item.label),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: AppDurations.fast,
                  curve: Curves.easeOut,
                  height: 2,
                  width: active ? 24 : 0,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
