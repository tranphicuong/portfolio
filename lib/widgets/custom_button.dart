import 'package:flutter/material.dart';

import '../utils/constants.dart';

enum ButtonVariant { filled, outlined }


class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = ButtonVariant.filled,
    this.isLoading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonVariant variant;
  final bool isLoading;

  
  final bool expand;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isFilled = widget.variant == ButtonVariant.filled;
    final enabled = widget.onPressed != null && !widget.isLoading;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );
    const padding = EdgeInsets.symmetric(horizontal: 24, vertical: 18);
    const textStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 15);

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              semanticsLabel: 'Đang xử lý',
              color: isFilled ? scheme.onPrimary : scheme.primary,
            ),
          )
        else if (widget.icon != null)
          Icon(widget.icon, size: 18),
        if (widget.isLoading || widget.icon != null) const SizedBox(width: 10),
        Flexible(
          child: Text(widget.label, overflow: TextOverflow.ellipsis),
        ),
      ],
    );

    final Widget button = isFilled
        ? FilledButton(
            onPressed: enabled ? widget.onPressed : null,
            style: FilledButton.styleFrom(
              padding: padding,
              shape: shape,
              textStyle: textStyle,
      
              disabledBackgroundColor:
                  widget.isLoading ? scheme.primary.withValues(alpha: 0.75) : null,
              disabledForegroundColor:
                  widget.isLoading ? scheme.onPrimary : null,
            ),
            child: content,
          )
        : OutlinedButton(
            onPressed: enabled ? widget.onPressed : null,
            style: OutlinedButton.styleFrom(
              padding: padding,
              shape: shape,
              textStyle: textStyle,
              side: BorderSide(color: scheme.outline.withValues(alpha: 0.6)),
            ),
            child: content,
          );

    final animated = MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered && enabled ? 1.04 : 1,
        duration: AppDurations.fast,
        curve: Curves.easeOut,
        child: button,
      ),
    );

    return widget.expand
        ? SizedBox(width: double.infinity, child: animated)
        : animated;
  }
}
