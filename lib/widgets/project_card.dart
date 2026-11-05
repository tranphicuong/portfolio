import 'package:flutter/material.dart';

import '../models/project.dart';
import '../utils/launcher.dart';
import 'hover_card.dart';
import 'safe_asset_image.dart';


class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  static const int _maxVisibleTags = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final visibleTags = project.technologies.take(_maxVisibleTags).toList();
    final hiddenCount = project.technologies.length - visibleTags.length;

    return Semantics(
      container: true,
      label: 'Dự án ${project.title}',
      child: HoverCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              width: double.infinity,
              child: SafeAssetImage(
                path: project.imagePath,
                semanticLabel: 'Ảnh chụp màn hình dự án ${project.title}',
                fallbackIcon: project.icon,
                fallbackLabel: project.title,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final tag in visibleTags) _TagChip(label: tag),
                        if (hiddenCount > 0) _TagChip(label: '+$hiddenCount'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () => openLink(context, project.githubUrl),
                          icon: const Icon(Icons.code_rounded, size: 18),
                          label: const Text('GitHub'),
                        ),
                        if (project.demoUrl != null)
                          TextButton.icon(
                            onPressed: () =>
                                openLink(context, project.demoUrl!),
                            icon: const Icon(Icons.open_in_new_rounded, size: 18),
                            label: const Text('Demo'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: scheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
