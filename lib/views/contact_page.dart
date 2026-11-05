import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/portfolio_data.dart';
import '../utils/launcher.dart';
import '../widgets/content_container.dart';
import '../widgets/contact_form.dart';
import '../widgets/hover_card.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scroll.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/surface_card.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScroll(
      slivers: [
        SliverToBoxAdapter(
          child: ContentContainer(
            top: 40,
            bottom: 28,
            child: PageHeader(
              eyebrow: 'Contact',
              title: 'Liên hệ',
              subtitle:
                  'Bạn có cơ hội hợp tác hoặc muốn trao đổi thêm? Hãy để lại '
                  'tin nhắn, mình sẽ phản hồi sớm nhất có thể.',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ContentContainer(bottom: 64, child: _ContactBody()),
        ),
      ],
    );
  }
}

class _ContactBody extends StatelessWidget {
  const _ContactBody();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const info = ScrollReveal(child: _ContactInfo());
        const form = ScrollReveal(
          delay: Duration(milliseconds: 120),
          child: SurfaceCard(
            padding: EdgeInsets.all(28),
            child: ContactForm(),
          ),
        );

        if (constraints.maxWidth >= 860) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: info),
              SizedBox(width: 32),
              Expanded(flex: 6, child: form),
            ],
          );
        }

        return const Column(
          children: [info, SizedBox(height: 24), form],
        );
      },
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: PortfolioData.email));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã sao chép email vào clipboard'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kết nối với mình', style: theme.textTheme.headlineSmall),
        const SizedBox(height: 16),
        _ContactTile(
          icon: Icons.mail_outline_rounded,
          label: 'Email (bấm để sao chép)',
          value: PortfolioData.email,
          onTap: () => _copyEmail(context),
        ),
        const SizedBox(height: 14),
        _ContactTile(
          icon: Icons.code_rounded,
          label: 'GitHub',
          value: PortfolioData.githubUrl,
          onTap: () => openLink(context, PortfolioData.githubUrl),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      button: true,
      label: '$label: $value',
      child: ExcludeSemantics(
        child: HoverCard(
          onTap: onTap,
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: scheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
