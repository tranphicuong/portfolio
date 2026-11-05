import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'constants.dart';

enum AppTransition { fade, slideFromRight, scale, slideUp }

//Tao mot trang moi voi hieu ung chuyen trang tuong ung
CustomTransitionPage<void> buildTransitionPage({
  required GoRouterState state,
  required Widget child,
  AppTransition transition = AppTransition.fade,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: _PageBackground(child: child),
    transitionDuration: AppDurations.pageTransition,
    reverseTransitionDuration: AppDurations.medium,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = animation.drive(CurveTween(curve: Curves.easeOutCubic));

      switch (transition) {
        case AppTransition.fade:
          return FadeTransition(opacity: curved, child: child);
        case AppTransition.slideFromRight:
          return SlideTransition(
            position: curved.drive(
              Tween<Offset>(begin: const Offset(0.12, 0), end: Offset.zero),
            ),
            child: FadeTransition(opacity: curved, child: child),
          );
        case AppTransition.scale:
          return ScaleTransition(
            scale: curved.drive(Tween<double>(begin: 0.92, end: 1)),
            child: FadeTransition(opacity: curved, child: child),
          );
        case AppTransition.slideUp:
          return SlideTransition(
            position: curved.drive(
              Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero),
            ),
            child: FadeTransition(opacity: curved, child: child),
          );
      }
    },
  );
}

//Nen cua trang
class _PageBackground extends StatelessWidget {
  const _PageBackground({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }
}

//Hieu ung chuyen trang tuong minh
class FadeSlidePageTransitionsBuilder extends PageTransitionsBuilder {
  const FadeSlidePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = animation.drive(CurveTween(curve: Curves.easeOutCubic));
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: curved.drive(
          Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero),
        ),
        child: child,
      ),
    );
  }
}
