import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    super.key,
    this.child,
    this.bgColor,
    this.padding,
    this.adaptive = true,
    this.borderRadius,
    this.marginTop,
    this.margin,
    this.gradient,
  });

  final Widget? child;
  final Color? bgColor;
  final double? marginTop;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool adaptive;
  final BorderRadius? borderRadius;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.00001),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: mq.padding.bottom + mq.viewInsets.bottom + 10,
            ),
            margin: getMargin(
              context,
              margin: margin,
              marginTop: marginTop,
              adaptive: adaptive,
            ),
            decoration: BoxDecoration(
              color: bgColor ?? theme.cardColor,
              gradient: gradient,
              borderRadius: borderRadius ??
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  static EdgeInsets getMargin(
    BuildContext context, {
    bool adaptive = true,
    EdgeInsets? margin,
    double? marginTop,
  }) {
    if (margin != null) return margin;
    final mq = MediaQuery.of(context);
    final finalMarginTop =
        marginTop ?? mq.padding.top + mq.viewInsets.top + (kIsWeb ? 0 : 30);
    final finalMargin = EdgeInsets.only(top: finalMarginTop);
    return finalMargin;
  }
}
