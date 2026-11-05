import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import 'safe_asset_image.dart';


class AnimatedAvatar extends StatefulWidget {
  const AnimatedAvatar({super.key, this.size = 280});

  final double size;

  @override
  State<AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<AnimatedAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  late final Animation<double> _float = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutSine,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -12 * _float.value),
          child: child,
        );
      },
      child: Semantics(
        image: true,
        label: 'Ảnh đại diện của ${PortfolioData.fullName}',
        child: Container(
          width: widget.size,
          height: widget.size,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [scheme.primary, scheme.tertiary],
            ),
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.35),
                blurRadius: 40,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: SafeAssetImage(
              path: PortfolioData.avatarPath,
              fallback: Container(
                color: scheme.primaryContainer,
                alignment: Alignment.center,
                child: Text(
                  PortfolioData.initials,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.w800,
                    fontSize: widget.size * 0.34,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
