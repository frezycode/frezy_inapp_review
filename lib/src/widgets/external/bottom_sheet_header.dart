import 'package:flutter/material.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    this.titleStyle,
    this.titlePadding,
    this.centerTitle = false,
  });

  final EdgeInsets? titlePadding;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trailingWidget = trailing ??
        Padding(
          padding: EdgeInsets.zero,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close_rounded, color: theme.hintColor),
          ),
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: переписать
          if (centerTitle) ...[
            Opacity(opacity: 0, child: trailing),
            const SizedBox(width: 16),
          ],
          Flexible(
            child: Padding(
              padding: titlePadding ??
                  const EdgeInsets.symmetric(vertical: 8.0).copyWith(left: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: titleStyle ?? theme.textTheme.headlineSmall,
                    textAlign: centerTitle ? TextAlign.center : null,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          trailingWidget,
        ],
      ),
    );
  }
}
