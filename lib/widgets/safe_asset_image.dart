import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SafeAssetImage extends StatelessWidget {
  const SafeAssetImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.semanticLabel,
    this.fallback,
    this.fallbackIcon = Icons.image_outlined,
    this.fallbackLabel,
  });

  final String path;
  final BoxFit fit;
  final String? semanticLabel;

  
  final Widget? fallback;
  final IconData fallbackIcon;
  final String? fallbackLabel;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      semanticLabel: semanticLabel,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: AppDurations.medium,
          curve: Curves.easeOut,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return fallback ??
            _DefaultFallback(icon: fallbackIcon, label: fallbackLabel);
      },
    );
  }
}

class _DefaultFallback extends StatelessWidget {
  const _DefaultFallback({required this.icon, this.label});

  final IconData icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primaryContainer, scheme.tertiaryContainer],
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 44, color: scheme.onPrimaryContainer),
          if (label != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: scheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
