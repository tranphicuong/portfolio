import 'package:flutter/material.dart';

import '../utils/constants.dart';


class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.borderRadius = 20,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovered = false;

  void _setHovered(bool value) {
    if (_hovered != value) setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final padding = widget.padding;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1,
        duration: AppDurations.fast,
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          curve: Curves.easeOut,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _hovered
                  ? scheme.primary.withValues(alpha: 0.6)
                  : scheme.outlineVariant,
            ),
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withValues(alpha: _hovered ? 0.18 : 0.04),
                blurRadius: _hovered ? 28 : 10,
                offset: Offset(0, _hovered ? 12 : 4),
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: widget.onTap,
              child: padding == null
                  ? widget.child
                  : Padding(padding: padding, child: widget.child),
            ),
          ),
        ),
      ),
    );
  }
}
