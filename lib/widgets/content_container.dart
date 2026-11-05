import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/responsive.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.child,
    this.top = 0,
    this.bottom = 0,
  });

  final Widget child;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            Responsive.horizontalPadding(context),
            top,
            Responsive.horizontalPadding(context),
            bottom,
          ),
          child: child,
        ),
      ),
    );
  }
}
