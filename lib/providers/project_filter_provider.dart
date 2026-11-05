import 'package:flutter/foundation.dart';

import '../data/portfolio_data.dart';
import '../models/project.dart';

//trang thai cua cac du an duoc loc theo tag
class ProjectFilterProvider extends ChangeNotifier {
  //Tag duoc chon de loc cac du an
  String? _selectedTag;

  String? get selectedTag => _selectedTag;

  List<Project> get filteredProjects {
    final tag = _selectedTag;
    if (tag == null) return PortfolioData.projects;
    return PortfolioData.projects
        .where((project) => project.technologies.contains(tag))
        .toList();
  }

  void select(String? tag) {
    if (_selectedTag == tag) return;
    _selectedTag = tag;
    notifyListeners();
  }
}
