import 'package:flutter/material.dart';

import '../models/timeline_entry.dart';

//mot moc trong timeline, hien thi thoi gian, tieu de, to chuc va cac chi tiet
class TimelineItem extends StatelessWidget {
  const TimelineItem({super.key, required this.entry, this.isLast = false});

  final TimelineEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return MergeSemantics(
      child: Stack(
        children: [
          if (!isLast)
            Positioned(
              left: 6,
              top: 20,
              bottom: 0,
              width: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 32, bottom: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.period,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(entry.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  entry.organization,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                if (entry.details.isNotEmpty) const SizedBox(height: 10),
                for (final detail in entry.details)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, right: 10),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: scheme.onSurfaceVariant,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(detail, style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 5,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: scheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: scheme.surface, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.4),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
