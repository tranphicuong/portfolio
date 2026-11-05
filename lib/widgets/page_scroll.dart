import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'app_footer.dart';

class PageScroll extends StatefulWidget {
  const PageScroll({super.key, required this.slivers});

  final List<Widget> slivers;

  @override
  State<PageScroll> createState() => _PageScrollState();
}

class _PageScrollState extends State<PageScroll> {
  static const double _showButtonOffset = 400;

  final ScrollController _controller = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShow = _controller.offset > _showButtonOffset;
    if (shouldShow != _showBackToTop) {
      setState(() => _showBackToTop = shouldShow);
    }
  }

  void _scrollToTop() {
    _controller.animateTo(
      0,
      duration: AppDurations.slow,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          controller: _controller,
          slivers: [
            ...widget.slivers,
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AppFooter(),
              ),
            ),
          ],
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: IgnorePointer(
            ignoring: !_showBackToTop,
            child: AnimatedScale(
              scale: _showBackToTop ? 1 : 0,
              duration: AppDurations.medium,
              curve: Curves.easeOutBack,
              child: Semantics(
                button: true,
                label: 'Lên đầu trang',
                child: FloatingActionButton.small(
                  heroTag: null,
                  tooltip: 'Lên đầu trang',
                  onPressed: _scrollToTop,
                  child: const Icon(Icons.keyboard_arrow_up_rounded),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
