import 'dart:math' as math;

import 'package:flutter/material.dart';

class ResponsiveWrapGrid extends StatelessWidget {
  const ResponsiveWrapGrid({
    super.key,
    required this.children,
    this.minItemWidth = 260,
    this.maxColumns = 4,
    this.spacing = 16,
  });

  final List<Widget> children;
  final double minItemWidth;
  final int maxColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;
        final fitted = ((available + spacing) / (minItemWidth + spacing)).floor();
        final columns = math.min(math.max(fitted, 1), maxColumns);
        final itemWidth = (available - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children) SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}
