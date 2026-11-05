import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'constants.dart';

enum ScreenType { mobile, tablet, desktop }


class Responsive {
  Responsive._();

  static ScreenType screenTypeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < Breakpoints.mobile) return ScreenType.mobile;
    if (width < Breakpoints.tablet) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      screenTypeOf(context) == ScreenType.mobile;

  //Chon giao dien nho hon 760px
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    switch (screenTypeOf(context)) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  static double horizontalPadding(BuildContext context) =>
      value<double>(context, mobile: 20, tablet: 32, desktop: 48);

  //Chieu rong noi dung chinh
  static double contentInset(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final extra = (width - Breakpoints.maxContentWidth) / 2;
    return math.max(0.0, extra) + horizontalPadding(context);
  }
}
