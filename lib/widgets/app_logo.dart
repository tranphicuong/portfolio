import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/portfolio_data.dart';
import '../utils/constants.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      button: true,
      label: 'Về trang chủ',
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => context.go(AppRoutes.home),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                PortfolioData.avatarPath,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 40,
                    height: 40,
                    color: scheme.primary.withValues(alpha: 0.12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      PortfolioData.initials,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Text(
              PortfolioData.fullName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            ],
          ),
          
        ),
      ),
    );
  }
}
