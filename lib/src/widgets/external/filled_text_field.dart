import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilledTextField extends StatefulWidget {
  const FilledTextField({
    super.key,
    this.hintText,
    this.controller,
    this.onTap,
    this.autoFocus = false,
    this.inputFormatters,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.border,
    this.focusedBorder,
    this.fillColor,
    this.textAlign = TextAlign.start,
    this.enabled,
    this.maxLines,
    this.alignLabelWithHint = false,
    this.disabledBorder,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.suffixIcon,
    this.minLines,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.contentPadding,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Function()? onTap;
  final Widget? prefixIcon;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final OutlineInputBorder? border;
  final OutlineInputBorder? focusedBorder;
  final Color? fillColor;
  final TextAlign textAlign;
  final bool? enabled;
  final int? maxLines;
  final int? minLines;
  final bool alignLabelWithHint;
  final FloatingLabelBehavior floatingLabelBehavior;
  final OutlineInputBorder? disabledBorder;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final EdgeInsets? contentPadding;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      readOnly: widget.readOnly,
      keyboardAppearance: Brightness.dark,
      controller: widget.controller,
      textAlign: widget.textAlign,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      style: TextStyle(
        fontSize: 16,
        color: theme.textTheme.bodyMedium?.color,
        fontWeight: FontWeight.w500,
      ),
      onTap: widget.onTap ?? () {},
      autofocus: widget.autoFocus,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      textInputAction: widget.textInputAction,
      decoration: _getInputDecoration(context),
    );
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final startBorder = widget.border ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        );
    return InputDecoration(
      prefixIcon: widget.prefixIcon,
      alignLabelWithHint: true,
      hintText: widget.hintText,
      labelStyle: widget.labelStyle ??
          TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
      labelText: widget.labelText ?? widget.hintText,
      hintStyle: widget.hintStyle ??
          TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
      floatingLabelStyle: TextStyle(
        color: theme.primaryColor,
        fontWeight: FontWeight.w600,
      ),
      filled: true,
      fillColor: widget.fillColor ?? _getFillColor(context),
      focusColor: theme.hintColor,
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      floatingLabelBehavior: widget.floatingLabelBehavior,
      border: startBorder,
      suffixIcon: widget.suffixIcon ??
          (widget.controller != null
              ? _ReplaceButton(controller: widget.controller!)
              : null),
      disabledBorder: widget.disabledBorder,
      errorBorder: widget.border ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
      focusedBorder: widget.focusedBorder ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: theme.primaryColor,
            ),
          ),
      enabledBorder: startBorder,
    );
  }

  Color? _getFillColor(BuildContext context) {
    final theme = Theme.of(context);
    return theme.hintColor.withOpacity(0.2);
  }
}

class _ReplaceButton extends StatelessWidget {
  const _ReplaceButton({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (controller.text.isEmpty) return const SizedBox();
        return InkWell(
          onTap: () => controller.clear(),
          child: const Icon(
            Icons.close_rounded,
            size: 20,
          ),
        );
      },
    );
  }
}
