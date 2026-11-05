import 'package:flutter/material.dart';

import '../models/project.dart';
import '../models/skill.dart';
import '../models/timeline_entry.dart';

class PortfolioData {
  PortfolioData._();

  //Thong tin ca nhan

  static const String fullName = 'Trần Phi Cường';
  static const String birthday = '06/07/2005';
  static const String phone = '0338 173 105';
  static const String address = '59/3a/1, đường số 8, phường Thủ Đức, TP. Hồ Chí Minh, Việt Nam';
  static const String role = 'Flutter Developer Intern';
  static const String tagline =
      'Lập trình viên mobile tốt nghiệp Cao đẳng Công nghệ Thông tin, đã thực '
      'hiện các ứng dụng Android, iOS và Flutter kết hợp Firebase. Thích học '
      'công nghệ mới và làm việc nhóm.';

  static const String email = 'cuongt6767@gmail.com';
  static const String githubUrl = 'https://github.com/tranphicuong';

  static const String avatarPath = 'assets/images/avatar.png';

  //file cv pdf
  static const String cvFilePath = 'cv/TRAN-PHI-CUONG-CV.pdf';

  static const String applyingFor = 'Thực tập sinh Lập trình Mobile (Flutter)';

  static const String objective =
      'Trở thành Flutter Developer chuyên nghiệp, xây dựng các ứng dụng đa '
      'nền tảng chất lượng cao. Mong muốn được thực tập trong môi trường thực '
      'tế để áp dụng nền tảng Android (Kotlin), iOS (Swift) và Firebase vào '
      'sản phẩm Flutter, đồng thời học hỏi quy trình làm việc nhóm, clean code '
      'và best practices của ngành.';

  //Lay chu cai dau tien cua ten
  static String get initials {
    final parts =
        fullName.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  //Hoc van & kinh nghiem lam viec

  static const List<TimelineEntry> education = [
    TimelineEntry(
      title: 'Công nghệ thông tin — Lập trình mobile',
      organization: 'Cao đẳng Công nghệ Thủ Đức',
      period: '9/2023 – 6/2026',
      details: [
        'GPA: 7.5/10.',
        'Tham gia các dự án nhóm phát triển ứng dụng di động trong môi '
            'trường học tập.',
        'Chủ động học hỏi công nghệ mới như Flutter, Firebase để nâng cao kỹ '
            'năng lập trình.',
        'Tham gia các buổi workshop và nhóm sinh viên CNTT để trao đổi, học '
            'hỏi kinh nghiệm.',
      ],
    ),
  ];

  static const List<TimelineEntry> experience = [
    TimelineEntry(
      title: 'Ứng dụng tìm đồ thất lạc FindBack',
      organization: 'Đồ án trên lớp · Kotlin (Android), Firebase, Claude AI',
      period: '4/2026',
      details: [
        'Mô tả: ứng dụng giúp người dùng đăng tải và tìm kiếm đồ thất lạc '
            'bằng cách nhắn tin, tích hợp gửi vị trí để người mất có thể di '
            'chuyển tới; dữ liệu lưu trữ và đồng bộ qua Firebase Realtime '
            'Database.',
        'Lên ý tưởng cho nhóm.',
        'Thiết kế các màn hình liên quan tới chức năng nhắn tin, bình luận, '
            'thông báo.',
        'Viết chức năng cho 3 tính năng: nhắn tin, bình luận, thông báo.',
        'Dùng OneSignal để gửi thông báo đẩy lên điện thoại thật.',
        'Hỗ trợ và fix các tính năng khác cho team khi gặp bug.',
      ],
    ),
    TimelineEntry(
      title: 'Ứng dụng chấm công TimeMark',
      organization:
          'Đồ án trên lớp · Swift (iOS), Firebase Firestore, Claude AI, '
          'Cloudinary',
      period: '4/2026 – 5/2026',
      details: [
        'Mô tả: ứng dụng quản lý chấm công cho một công ty — giúp người dùng '
            'quản lý thời gian đi làm của bản thân, giúp công ty quản lý nhân '
            'sự và xuất file Excel để thanh toán lương.',
        'Lên ý tưởng, tham gia thiết kế database và thiết kế toàn bộ layout '
            'của ứng dụng.',
        'Thảo luận và đóng góp ý kiến cho các tính năng.',
        'Viết các tính năng phần User: đăng nhập, check-in/check-out, nghỉ '
            'phép năm, thông báo, lịch sử, hồ sơ cá nhân.',
        'Upload ảnh lên Cloudinary để lưu trữ.',
      ],
    ),
    TimelineEntry(
      title: 'Ứng dụng đặt sân online FieldsHub',
      organization:
          'Đồ án học phần Lập trình mobile · Flutter, VS Code, Firebase, '
          'Render, GitHub, Cloudinary',
      period: '9/2025 – 11/2025',
      details: [
        'Mô tả: hệ thống đặt sân online cơ bản, hỗ trợ người dùng tìm sân gần '
            'và phù hợp; dữ liệu lưu trữ và đồng bộ qua Firebase Firestore.',
        'Thiết kế UI cho user và admin; thiết kế database cho đồ án.',
        'Làm các chức năng của user: đăng ký, đăng nhập, quên mật khẩu; hiển '
            'thị danh sách sân từ dữ liệu; tìm kiếm sân; nhắn tin với chủ '
            'sân; hồ sơ cá nhân.',
        'Chức năng đặt sân: chọn thời gian, chọn hình thức thanh toán (trả '
            'hết hoặc cọc), hiển thị mã QR thanh toán đúng số tiền và tự động '
            'nhận diện khi đã thanh toán.',
        'Tính năng: phân loại sân, upload ảnh, tìm kiếm và bộ lọc, đặt sân và '
            'thanh toán, chat.',
      ],
    ),
    TimelineEntry(
      title: 'Thực tập sinh',
      organization: 'Bệnh viện đa khoa Thủ Đức',
      period: '6/2025 – 8/2025',
      details: [
        'Đi dây mạng, sửa máy tính và máy in.',
        'Fix các barcode bị lỗi và cập nhật phần mềm MQ cho bệnh viện.',
      ],
    ),
    TimelineEntry(
      title: 'Phục vụ — Bar — Boy — Thu ngân (làm thêm)',
      organization: 'Galbi House',
      period: '3/2025 – 1/2026',
      details: [
        'Phục vụ khách hàng chuyên nghiệp, đạt giải Best Staff tháng 12/2025.',
        'Phối hợp nhịp nhàng với từng bộ phận để giúp nhà hàng đạt doanh thu.',
      ],
    ),
  ];

  //skills & phan tram thanh thao
  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Ngôn ngữ & Framework',
      icon: Icons.code_rounded,
      skills: [ 
        Skill(name: 'Kotlin (Android)', level: 0.75, icon: Icons.android),
        Skill(name: 'Java', level: 0.65, icon: Icons.coffee_rounded),
        Skill(name: 'Swift (iOS)', level: 0.55, icon: Icons.phone_iphone_rounded),
        Skill(name: 'C#', level: 0.55, icon: Icons.integration_instructions_rounded),
        Skill(name: 'Flutter', level: 0.55, icon: Icons.flutter_dash),
        Skill(name: 'Dart', level: 0.55, icon: Icons.code_rounded),
      ],
    ),
    SkillCategory(
      title: 'Dữ liệu & Web',
      icon: Icons.storage_rounded,
      skills: [
        Skill(
          name: 'Firebase (Realtime DB, Firestore)',
          level: 0.80,
          icon: Icons.local_fire_department_rounded,
        ),
        Skill(name: 'SQL Server', level: 0.60, icon: Icons.storage_rounded),
        Skill(name: 'MySQL', level: 0.60, icon: Icons.dns_rounded),
        Skill(name: 'HTML / CSS / PHP', level: 0.50, icon: Icons.language_rounded),
      ],
    ),
    SkillCategory(
      title: 'Công cụ',
      icon: Icons.build_rounded,
      skills: [
        Skill(name: 'Git & GitHub', level: 0.70, icon: Icons.merge_type_rounded),
        Skill(name: 'Figma', level: 0.65, icon: Icons.design_services_rounded),
        Skill(
          name: 'Android Studio / VS Code',
          level: 0.80,
          icon: Icons.terminal_rounded,
        ),
        Skill(name: 'OneSignal / Cloudinary', level: 0.60, icon: Icons.cloud_rounded),
      ],
    ),
  ];

  static const List<SoftSkill> softSkills = [
    SoftSkill(
      name: 'Làm việc nhóm',
      description:
          'Tham gia ý tưởng, thiết kế và chia việc cùng nhóm; hỗ trợ đồng '
          'đội fix bug khi cần.',
      icon: Icons.groups_rounded,
    ),
    SoftSkill(
      name: 'Giao tiếp hiệu quả',
      description:
          'Thảo luận, góp ý tính năng và phối hợp nhịp nhàng giữa các bộ '
          'phận.',
      icon: Icons.forum_rounded,
    ),
    SoftSkill(
      name: 'Tự học',
      description:
          'Chủ động tìm hiểu công nghệ mới (Flutter, Swift, Firebase...) để '
          'nâng cao kỹ năng lập trình.',
      icon: Icons.auto_stories_rounded,
    ),
    SoftSkill(
      name: 'Phục vụ khách hàng',
      description:
          'Kinh nghiệm làm thêm tại nhà hàng, đạt giải Best Staff tháng '
          '12/2025.',
      icon: Icons.emoji_events_rounded,
    ),
  ];

 //Du an da lam
  static const List<Project> projects = [
    Project(
      id: 'portfolio',
      title: 'Personal Portfolio (Flutter)',
      description:
          'CV điện tử đa nền tảng: responsive, dark mode, page transition, lọc '
          'dự án theo tag và form liên hệ có validation.',
      imagePath: 'assets/images/project_portfolio.png',
      technologies: ['Flutter', 'Dart', 'Provider', 'Responsive', 'UI Kit'],
      githubUrl: 'https://github.com/tranphicuong/cv_portfolio',
      icon: Icons.web_rounded,
    ),
    Project(
      id: 'fieldshub',
      title: 'FieldsHub — Đặt sân online',
      description:
          'Đồ án học phần Lập trình mobile. Tìm sân gần và phù hợp, đặt sân '
          'chọn thời gian, thanh toán trả hết hoặc cọc bằng mã QR tự động '
          'nhận diện đã thanh toán, nhắn tin với chủ sân. Dữ liệu đồng bộ '
          'qua Firebase Firestore.',
      imagePath: 'assets/images/project_fieldshub.png',
      technologies: [
        'Flutter',
        'Firebase',
        'Firestore',
        'Cloudinary',
        'Render',
        'API',
      ],
      githubUrl:
          'https://github.com/tranphicuong/FieldsHub_Project/tree/feature/cuong',
      icon: Icons.sports_soccer_rounded,
    ),
    Project(
      id: 'timemark',
      title: 'TimeMark — Chấm công',
      description:
          'Ứng dụng quản lý chấm công cho công ty: check-in/check-out, nghỉ '
          'phép năm, thông báo, lịch sử, hồ sơ cá nhân; công ty xuất file '
          'Excel để thanh toán lương. Phụ trách toàn bộ layout và phần User.',
      imagePath: 'assets/images/project_timemark.png',
      technologies: ['Swift', 'iOS', 'Firebase', 'Firestore', 'Cloudinary'],
      githubUrl: 'https://github.com/tranphicuong/TimeMark',
      icon: Icons.access_time_filled_rounded,
    ),
    Project(
      id: 'findback',
      title: 'FindBack — Tìm đồ thất lạc',
      description:
          'Đồ án trên lớp. Đăng tải và tìm kiếm đồ thất lạc bằng nhắn tin, '
          'gửi vị trí để người mất di chuyển tới. Phụ trách nhắn tin, bình '
          'luận, thông báo đẩy (OneSignal).',
      imagePath: 'assets/images/project_findback.png',
      technologies: [
        'Android',
        'Kotlin',
        'Firebase',
        'Realtime Database',
        'OneSignal',
      ],
      githubUrl: 'https://github.com/phuckk05/FindBack',
      icon: Icons.travel_explore_rounded,
    ),
  ];

  static List<String> get allTags {
    final tags = <String>{
      for (final project in projects) ...project.technologies,
    };
    return tags.toList()..sort();
  }

  static int countForTag(String tag) =>
      projects.where((project) => project.technologies.contains(tag)).length;
}
