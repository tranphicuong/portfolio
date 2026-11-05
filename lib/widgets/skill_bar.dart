import 'package:flutter/material.dart';

import '../models/skill.dart';
import 'scroll_reveal.dart';

//thanh ky nang hien thi muc do ky nang bang thanh ngang
class SkillBar extends StatelessWidget {
  const SkillBar({super.key, required this.skill});

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      label: '${skill.name}, mức độ ${skill.percent} phần trăm',
      child: ExcludeSemantics(
        child: RevealBuilder(
          builder: (context, visible) {
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: visible ? skill.level : 0),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(skill.icon, size: 18, color: scheme.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            skill.name,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${(value * 100).round()}%',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                      color: scheme.primary,
                      backgroundColor: scheme.primary.withValues(alpha: 0.12),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
