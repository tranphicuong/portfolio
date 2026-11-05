import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/portfolio_data.dart';
import '../utils/constants.dart';
import '../utils/launcher.dart';
import 'animated_avatar.dart';
import 'custom_button.dart';
import 'scroll_reveal.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 820;
        final intro = _HeroIntro(centered: !wide);
        final avatar = AnimatedAvatar(size: wide ? 320 : 220);

        if (wide) {
          return Row(
            children: [
              Expanded(flex: 6, child: intro),
              const SizedBox(width: 48),
              Expanded(flex: 4, child: Center(child: avatar)),
            ],
          );
        }

        return Column(
          children: [
            avatar,
            const SizedBox(height: 36),
            intro,
          ],
        );
      },
    );
  }
}

class _HeroIntro extends StatelessWidget {
  const _HeroIntro({required this.centered});

  final bool centered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final alignment =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    final nameStyle = (centered
            ? theme.textTheme.displayMedium
            : theme.textTheme.displayLarge)
        ?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      letterSpacing: -2,
      height: 1.05,
    );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        ScrollReveal(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.waving_hand_rounded,
                    size: 18, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Xin chào, mình là',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ScrollReveal(
          delay: const Duration(milliseconds: 100),
          child: Semantics(
            header: true,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                colors: [scheme.primary, scheme.tertiary],
              ).createShader(bounds),
              child: Text(
                PortfolioData.fullName,
                textAlign: textAlign,
                style: nameStyle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ScrollReveal(
          delay: const Duration(milliseconds: 200),
          child: Text(
            PortfolioData.role,
            textAlign: textAlign,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ScrollReveal(
          delay: const Duration(milliseconds: 300),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              PortfolioData.tagline,
              textAlign: textAlign,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        ScrollReveal(
          delay: const Duration(milliseconds: 400),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: centered ? WrapAlignment.center : WrapAlignment.start,
            children: [
              CustomButton(
                label: 'Xem dự án',
                icon: Icons.arrow_forward_rounded,
                onPressed: () => context.go(AppRoutes.projects),
              ),
              CustomButton(
                label: 'Liên hệ',
                icon: Icons.mail_outline_rounded,
                variant: ButtonVariant.outlined,
                onPressed: () => context.go(AppRoutes.contact),
              ),
              CustomButton(
                label: 'Tải CV',
                icon: Icons.download_rounded,
                variant: ButtonVariant.outlined,
                onPressed: () => openCV(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ScrollReveal(
          delay: const Duration(milliseconds: 500),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.filledTonal(
                tooltip: 'GitHub',
                onPressed: () => openLink(context, PortfolioData.githubUrl),
                icon: const Icon(Icons.code_rounded),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                tooltip: 'Gửi email',
                onPressed: () =>
                    openLink(context, 'mailto:${PortfolioData.email}'),
                icon: const Icon(Icons.mail_outline_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
