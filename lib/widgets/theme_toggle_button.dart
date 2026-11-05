import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../utils/constants.dart';

//nut chuyen doi giao dien sang sang / toi
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return IconButton(
      tooltip: isDark ? 'Chuyển sang giao diện sáng' : 'Chuyển sang giao diện tối',
      onPressed: () => context.read<ThemeProvider>().toggle(brightness),
      icon: AnimatedSwitcher(
        duration: AppDurations.medium,
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey<bool>(isDark),
        ),
      ),
    );
  }
}
