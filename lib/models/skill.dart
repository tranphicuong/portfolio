import 'package:flutter/widgets.dart';

class Skill {
  const Skill({required this.name, required this.level, required this.icon})
      : assert(level >= 0 && level <= 1);

  final String name;
  final double level;
  final IconData icon;

  int get percent => (level * 100).round();
}

class SkillCategory {
  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });

  final String title;
  final IconData icon;
  final List<Skill> skills;
}

class SoftSkill {
  const SoftSkill({
    required this.name,
    required this.description,
    required this.icon,
  });

  final String name;
  final String description;
  final IconData icon;
}
