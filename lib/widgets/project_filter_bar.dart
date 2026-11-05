import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/portfolio_data.dart';
import '../providers/project_filter_provider.dart';

class ProjectFilterBar extends StatelessWidget {
  const ProjectFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<ProjectFilterProvider>();

    return Semantics(
      container: true,
      label: 'Bộ lọc dự án theo công nghệ',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ChoiceChip(
            label: Text('Tất cả (${PortfolioData.projects.length})'),
            selected: filter.selectedTag == null,
            onSelected: (_) => filter.select(null),
          ),
          for (final tag in PortfolioData.allTags)
            ChoiceChip(
              label: Text('$tag (${PortfolioData.countForTag(tag)})'),
              //bam lai tag dang chon thi bo chon
              selected: filter.selectedTag == tag,
              onSelected: (_) =>
                  filter.select(filter.selectedTag == tag ? null : tag),
            ),
        ],
      ),
    );
  }
}
