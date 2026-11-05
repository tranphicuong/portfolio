import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/project_filter_provider.dart';
import '../utils/constants.dart';
import '../widgets/content_container.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scroll.dart';
import '../widgets/project_card.dart';
import '../widgets/project_filter_bar.dart';
import '../widgets/scroll_reveal.dart';

//Du an loc theo tag, hien thi danh sach du an
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  //Chieu cao cua the du an
  static const double _cardHeight = 470;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<ProjectFilterProvider>();
    final projects = filter.filteredProjects;

    return PageScroll(
      slivers: [
        const SliverToBoxAdapter(
          child: ContentContainer(
            top: 40,
            bottom: 24,
            child: PageHeader(
              eyebrow: 'Projects',
              title: 'Dự án',
              subtitle:
                  'Một số sản phẩm mình đã xây dựng. Chọn một công nghệ bên '
                  'dưới để lọc danh sách dự án.',
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: ContentContainer(bottom: 16, child: ProjectFilterBar()),
        ),
        SliverToBoxAdapter(
          child: ContentContainer(
            bottom: 16,
            child:
                _ResultSummary(count: projects.length, tag: filter.selectedTag),
          ),
        ),
        if (projects.isEmpty)
          const SliverToBoxAdapter(
            child: ContentContainer(bottom: 48, child: _EmptyState()),
          )
        else
          SliverToBoxAdapter(
            child: ContentContainer(
              bottom: 64,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final columns = width >= 900 ? 3 : (width >= 600 ? 2 : 1);

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: projects.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      mainAxisExtent: _cardHeight,
                    ),
                    findChildIndexCallback: (key) {
                      if (key is! ValueKey<String>) {
                        return null;
                      }
                      final index =
                          projects.indexWhere((p) => p.id == key.value);
                      return index < 0 ? null : index;
                    },
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return ScrollReveal(
                        key: ValueKey<String>(project.id),
                        delay: Duration(milliseconds: (index % columns) * 80),
                        child: ProjectCard(project: project),
                      );
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _ResultSummary extends StatelessWidget {
  const _ResultSummary({required this.count, required this.tag});

  final int count;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = tag == null
        ? 'Hiển thị tất cả $count dự án'
        : 'Hiển thị $count dự án với công nghệ "$tag"';

    return AnimatedSwitcher(
      duration: AppDurations.fast,
      child: Align(
        key: ValueKey<String>(text),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.search_off_rounded, size: 56, color: scheme.outline),
            const SizedBox(height: 12),
            Text('Chưa có dự án nào phù hợp',
                style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
