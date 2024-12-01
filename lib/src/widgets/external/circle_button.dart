import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 60,
    this.backgroundColor,
    this.iconSize,
    this.title,
    this.boxShadow,
  });

  final Widget icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double size;
  final Size? iconSize;
  final String? title;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor ?? theme.primaryColor,
                boxShadow: boxShadow ??
                    [
                      BoxShadow(
                        color: theme.shadowColor.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 5),
                      )
                    ],
              ),
              child: Center(
                child: SizedBox.fromSize(
                  size: iconSize,
                  child: icon,
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(200),
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
        if (title != null) ...[
          const SizedBox(height: 6),
          Text(title!),
        ],
      ],
    );
  }
}
