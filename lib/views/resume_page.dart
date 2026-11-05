import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/timeline_entry.dart';
import '../widgets/content_container.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scroll.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/surface_card.dart';
import '../widgets/timeline_item.dart';


class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScroll(
      slivers: [
        SliverToBoxAdapter(
          child: ContentContainer(
            top: 40,
            bottom: 28,
            child: PageHeader(
              eyebrow: 'Resume',
              title: 'Hồ sơ chi tiết',
              subtitle:
                  'Thông tin cá nhân, mục tiêu nghề nghiệp, quá trình học tập '
                  'và kinh nghiệm thực hiện dự án.',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ContentContainer(bottom: 40, child: _ProfileSection()),
        ),
        SliverToBoxAdapter(
          child: ContentContainer(bottom: 64, child: _TimelineSection()),
        ),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const info = ScrollReveal(child: _InfoCard());
        const objective = ScrollReveal(
          delay: Duration(milliseconds: 120),
          child: _ObjectiveCard(),
        );

        if (constraints.maxWidth >= 820) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: info),
              SizedBox(width: 24),
              Expanded(flex: 6, child: objective),
            ],
          );
        }

        return const Column(
          children: [info, SizedBox(height: 20), objective],
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text('Thông tin cá nhân', style: theme.textTheme.titleLarge),
          ),
          const SizedBox(height: 18),
          const _InfoRow(label: 'Họ tên', value: PortfolioData.fullName),
          const _InfoRow(label: 'Ngày sinh', value: PortfolioData.birthday),
          const _InfoRow(label: 'Số điện thoại', value: PortfolioData.phone),
          const _InfoRow(label: 'Địa chỉ', value: PortfolioData.address),
          const _InfoRow(label: 'Email', value: PortfolioData.email),
          const _InfoRow(label: 'GitHub', value: PortfolioData.githubUrl),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ObjectiveCard extends StatelessWidget {
  const _ObjectiveCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag_rounded, color: scheme.primary),
              const SizedBox(width: 10),
              Semantics(
                header: true,
                child: Text(
                  'Mục tiêu nghề nghiệp',
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(PortfolioData.objective, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _TimelineSection extends StatelessWidget {
  const _TimelineSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const education = _TimelineColumn(
          title: 'Học vấn',
          icon: Icons.school_rounded,
          entries: PortfolioData.education,
        );
        const experience = _TimelineColumn(
          title: 'Kinh nghiệm',
          icon: Icons.work_rounded,
          entries: PortfolioData.experience,
        );

        if (constraints.maxWidth >= 820) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: education),
              SizedBox(width: 40),
              Expanded(child: experience),
            ],
          );
        }

        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [education, SizedBox(height: 32), experience],
        );
      },
    );
  }
}

class _TimelineColumn extends StatelessWidget {
  const _TimelineColumn({
    required this.title,
    required this.icon,
    required this.entries,
  });

  final String title;
  final IconData icon;
  final List<TimelineEntry> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: scheme.primary),
              ),
              const SizedBox(width: 12),
              Semantics(
                header: true,
                child: Text(title, style: theme.textTheme.headlineSmall),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        for (var i = 0; i < entries.length; i++)
          ScrollReveal(
            delay: Duration(milliseconds: i * 100),
            child: TimelineItem(
              entry: entries[i],
              isLast: i == entries.length - 1,
            ),
          ),
      ],
    );
  }
}
