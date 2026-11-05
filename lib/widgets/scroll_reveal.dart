import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

typedef RevealWidgetBuilder = Widget Function(
  BuildContext context,
  bool visible,
);


class RevealBuilder extends StatefulWidget {
  const RevealBuilder({
    super.key,
    required this.builder,
    this.delay = Duration.zero,
    this.triggerFraction = 0.92,
  });

  final RevealWidgetBuilder builder;

  //do tre 
  final Duration delay;

  //ti le chieu cao cua man hinh de hien thi widget
  final double triggerFraction;

  @override
  State<RevealBuilder> createState() => _RevealBuilderState();
}

class _RevealBuilderState extends State<RevealBuilder> {
  bool _visible = false;
  bool _scheduled = false;
  double _screenHeight = 0;
  ScrollPosition? _position;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.sizeOf(context).height;

    final newPosition = Scrollable.maybeOf(context)?.position;
    if (newPosition != _position) {
      _position?.removeListener(_check);
      _position = newPosition;
      _position?.addListener(_check);
    }

    //kiem tra xem widget da hien thi tren man hinh chua, neu roi thi khong can check nua
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_visible || _scheduled || !mounted) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox ||
        !renderObject.attached ||
        !renderObject.hasSize) {
      return;
    }

    final top = renderObject.localToGlobal(Offset.zero).dy;
    if (top < _screenHeight * widget.triggerFraction) {
      _scheduled = true;
      _timer = Timer(widget.delay, () {
        if (mounted) setState(() => _visible = true);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _position?.removeListener(_check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _visible);
}

//hieu ung cuon vao hien thi widget
class ScrollReveal extends StatelessWidget {
  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 0.08),
  });

  final Widget child;
  final Duration delay;

  //do lech cua widget so voi vi tri cuoi cung cua man hinh, tinh theo ty le chieu cao cua man hinh
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return RevealBuilder(
      delay: delay,
      builder: (context, visible) {
        return AnimatedSlide(
          offset: visible ? Offset.zero : offset,
          duration: AppDurations.slow,
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: AppDurations.slow,
            curve: Curves.easeOut,
            child: child,
          ),
        );
      },
    );
  }
}
