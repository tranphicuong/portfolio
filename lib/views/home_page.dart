import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/portfolio_data.dart';
import '../utils/constants.dart';
import '../widgets/content_container.dart';
import '../widgets/hero_section.dart';
import '../widgets/hover_card.dart';
import '../widgets/page_scroll.dart';
import '../widgets/responsive_wrap_grid.dart';
import '../widgets/scroll_reveal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScroll(
      slivers: [
        SliverToBoxAdapter(
          child: ContentContainer(top: 48, bottom: 40, child: HeroSection()),
        ),
        SliverToBoxAdapter(
          child: ContentContainer(bottom: 40, child: _StatsSection()),
        ),
        SliverToBoxAdapter(
          child: ContentContainer(bottom: 64, child: _QuickLinksSection()),
        ),
      ],
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    final stats = [
      (PortfolioData.projects.length, 'Dự án đã thực hiện'),
      (
        PortfolioData.skillCategories
            .fold<int>(0, (total, group) => total + group.skills.length),
        'Kỹ năng chuyên môn',
      ),
      (PortfolioData.allTags.length, 'Công nghệ sử dụng'),
    ];

    return ResponsiveWrapGrid(
      minItemWidth: 200,
      maxColumns: 3,
      children: [
        for (var i = 0; i < stats.length; i++)
          ScrollReveal(
            delay: Duration(milliseconds: i * 120),
            child: _StatTile(value: stats[i].$1, label: stats[i].$2),
          ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return HoverCard(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: value),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, current, _) => Text(
              '$current',
              style: theme.textTheme.displaySmall?.copyWith(
                color: scheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickLink {
  const _QuickLink({
    required this.title,
    required this.description,
    required this.icon,
    required this.path,
  });

  final String title;
  final String description;
  final IconData icon;
  final String path;
}

class _QuickLinksSection extends StatelessWidget {
  const _QuickLinksSection();

  static const List<_QuickLink> _links = [
    _QuickLink(
      title: 'Hồ sơ chi tiết',
      description: 'Học vấn, kinh nghiệm và mục tiêu nghề nghiệp.',
      icon: Icons.badge_rounded,
      path: AppRoutes.resume,
    ),
    _QuickLink(
      title: 'Kỹ năng',
      description: 'Kỹ năng chuyên môn và kỹ năng mềm.',
      icon: Icons.bolt_rounded,
      path: AppRoutes.skills,
    ),
    _QuickLink(
      title: 'Dự án',
      description: 'Các sản phẩm đã làm, lọc theo công nghệ.',
      icon: Icons.folder_special_rounded,
      path: AppRoutes.projects,
    ),
    _QuickLink(
      title: 'Liên hệ',
      description: 'Gửi tin nhắn hoặc kết nối qua email, GitHub.',
      icon: Icons.mail_rounded,
      path: AppRoutes.contact,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          child: Semantics(
            header: true,
            child: Text('Khám phá', style: theme.textTheme.headlineMedium),
          ),
        ),
        const SizedBox(height: 20),
        ResponsiveWrapGrid(
          minItemWidth: 240,
          maxColumns: 4,
          children: [
            for (var i = 0; i < _links.length; i++)
              ScrollReveal(
                delay: Duration(milliseconds: i * 100),
                child: _QuickLinkCard(link: _links[i]),
              ),
          ],
        ),
      ],
    );
  }
}

class _QuickLinkCard extends StatelessWidget {
  const _QuickLinkCard({required this.link});

  final _QuickLink link;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      button: true,
      label: link.title,
      child: HoverCard(
        padding: const EdgeInsets.all(22),
        onTap: () => context.go(link.path),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(link.icon, color: scheme.primary),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(link.title, style: theme.textTheme.titleMedium),
                ),
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              link.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
