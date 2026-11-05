import 'package:cv_portfolio/data/portfolio_data.dart';
import 'package:cv_portfolio/providers/project_filter_provider.dart';
import 'package:cv_portfolio/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators.name', () {
    test('báo lỗi khi rỗng hoặc quá ngắn', () {
      expect(Validators.name(null), isNotNull);
      expect(Validators.name('   '), isNotNull);
      expect(Validators.name('A'), isNotNull);
    });

    test('hợp lệ khi đủ ký tự', () {
      expect(Validators.name('Cuong'), isNull);
    });
  });

  group('Validators.email', () {
    test('báo lỗi khi rỗng hoặc sai định dạng', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('abc'), isNotNull);
      expect(Validators.email('abc@'), isNotNull);
      expect(Validators.email('abc@gmail'), isNotNull);
      expect(Validators.email('abc @gmail.com'), isNotNull);
    });

    test('hợp lệ khi đúng định dạng', () {
      expect(Validators.email('ten@gmail.com'), isNull);
      expect(Validators.email('  ten.ho+cv@mail.example.vn '), isNull);
    });
  });

  group('Validators.message', () {
    test('báo lỗi khi rỗng hoặc dưới 20 ký tự', () {
      expect(Validators.message(''), isNotNull);
      expect(Validators.message('Xin chào bạn'), isNotNull);
      expect(Validators.message('a' * 19), isNotNull);
    });

    test('hợp lệ khi từ 20 ký tự trở lên', () {
      expect(Validators.message('a' * 20), isNull);
    });
  });

  group('ProjectFilterProvider', () {
    test('mặc định hiển thị tất cả dự án', () {
      final provider = ProjectFilterProvider();
      expect(provider.filteredProjects.length, PortfolioData.projects.length);
    });

    test('lọc theo tag chỉ trả về dự án có tag đó', () {
      final provider = ProjectFilterProvider()..select('Flutter');
      expect(provider.filteredProjects, isNotEmpty);
      expect(
        provider.filteredProjects
            .every((project) => project.technologies.contains('Flutter')),
        isTrue,
      );
    });

    test('select(null) bỏ lọc', () {
      final provider = ProjectFilterProvider()
        ..select('Firebase')
        ..select(null);
      expect(provider.filteredProjects.length, PortfolioData.projects.length);
    });
  });
}
