import 'package:flutter/material.dart';

class Project {
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.technologies,
    required this.githubUrl,
    this.demoUrl,
    this.icon = Icons.phone_android_rounded,
  });

  final String id;
  final String title;
  final String description;

  //Duong dan den anh 
  final String imagePath;

  //Cac cong nghe duoc su dung trong du an
  final List<String> technologies;
  final String githubUrl;
  final String? demoUrl;

  //Icon hien thi khi chua co anh
  final IconData icon;
}
