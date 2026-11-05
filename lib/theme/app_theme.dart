import 'package:flutter/material.dart';

import '../utils/page_transitions.dart';

class AppTheme {
  AppTheme._();

  static const Color seedColor = Color(0xFF4F46E5);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
    );
    final scaffoldColor =
        isDark ? const Color(0xFF0B0F1A) : const Color(0xFFF8FAFC);

    final textTheme = base.textTheme.copyWith(
      displayMedium: base.textTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        height: 1.05,
      ),
      displaySmall: base.textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      ),
      headlineLarge: base.textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      headlineMedium: base.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: base.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      titleLarge: base.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      titleMedium: base.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.6),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.55),
    );

    return base.copyWith(
      scaffoldBackgroundColor: scaffoldColor,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        shape: Border(
          bottom: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.iOS: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.linux: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.macOS: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.windows: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.fuchsia: FadeSlidePageTransitionsBuilder(),
        },
      ),
    );
  }
}
