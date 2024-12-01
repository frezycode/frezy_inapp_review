import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.title,
    this.onPressed,
    this.height = 50,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.titleWidget,
    this.titleStyle,
    this.elevation,
    this.enabled = true,
    this.shadowColor,
  }) : assert((title == null && titleWidget == null) ||
            !(title != null && titleWidget != null));

  final String? title;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Widget? titleWidget;
  final TextStyle? titleStyle;
  final bool enabled;
  final double? elevation;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fillColor = (enabled
        ? Theme.of(context).primaryColor
        : Theme.of(context).disabledColor.withOpacity(0.2));
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          elevation:
              elevation != null ? WidgetStateProperty.all(elevation) : null,
          shadowColor: WidgetStateProperty.all(
              shadowColor ?? theme.shadowColor.withOpacity(0.7)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(16),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return theme.hintColor.withOpacity(0.8);
              }
              return backgroundColor ?? fillColor;
            },
          ),
        ),
        child: title != null
            ? Text(title!, style: titleStyle ?? theme.textTheme.bodyLarge)
            : titleWidget,
      ),
    );
  }
}
