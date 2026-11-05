import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/skill.dart';
import '../widgets/content_container.dart';
import '../widgets/hover_card.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scroll.dart';
import '../widgets/responsive_wrap_grid.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/skill_bar.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScroll(
      slivers: [
        SliverToBoxAdapter(
          child: ContentContainer(
            top: 40,
            bottom: 28,
            child: PageHeader(
              eyebrow: 'Skills',
              title: 'Kỹ năng',
              subtitle:
                  'Những công nghệ mình đang sử dụng hằng ngày và các kỹ năng '
                  'mềm giúp mình làm việc hiệu quả trong nhóm.',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ContentContainer(bottom: 48, child: _TechnicalSkills()),
        ),
        SliverToBoxAdapter(
          child: ContentContainer(bottom: 64, child: _SoftSkills()),
        ),
      ],
    );
  }
}

class _TechnicalSkills extends StatelessWidget {
  const _TechnicalSkills();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          child: Semantics(
            header: true,
            child: Text('Kỹ năng chuyên môn', style: theme.textTheme.headlineMedium),
          ),
        ),
        const SizedBox(height: 20),
        ResponsiveWrapGrid(
          minItemWidth: 320,
          maxColumns: 3,
          children: [
            for (var i = 0; i < PortfolioData.skillCategories.length; i++)
              ScrollReveal(
                delay: Duration(milliseconds: i * 120),
                child: _SkillCategoryCard(
                  category: PortfolioData.skillCategories[i],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category});

  final SkillCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return HoverCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(category.icon, color: scheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(category.title, style: theme.textTheme.titleLarge),
              ),
            ],
          ),
          const SizedBox(height: 22),
          for (final skill in category.skills) ...[
            SkillBar(skill: skill),
            const SizedBox(height: 18),
          ],
        ],
      ),
    );
  }
}

class _SoftSkills extends StatelessWidget {
  const _SoftSkills();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          child: Semantics(
            header: true,
            child: Text('Kỹ năng mềm', style: theme.textTheme.headlineMedium),
          ),
        ),
        const SizedBox(height: 20),
        ResponsiveWrapGrid(
          minItemWidth: 260,
          maxColumns: 3,
          children: [
            for (var i = 0; i < PortfolioData.softSkills.length; i++)
              ScrollReveal(
                delay: Duration(milliseconds: (i % 3) * 100),
                child: _SoftSkillCard(skill: PortfolioData.softSkills[i]),
              ),
          ],
        ),
      ],
    );
  }
}

class _SoftSkillCard extends StatelessWidget {
  const _SoftSkillCard({required this.skill});

  final SoftSkill skill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return MergeSemantics(
      child: HoverCard(
        padding: const EdgeInsets.all(22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: scheme.tertiary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(skill.icon, color: scheme.tertiary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(skill.name, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    skill.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
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
