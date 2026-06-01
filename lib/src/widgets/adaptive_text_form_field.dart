import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../theme/adaptive_theme_provider.dart';

/// TextFormField adattivo (TextFormField / CupertinoTextField con validazione)
class AdaptiveFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final EdgeInsets? padding;
  final bool enabled;

  const AdaptiveFormField({
    Key? key,
    this.controller,
    this.placeholder,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.padding,
    this.enabled = true,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveThemeProvider.of(context);

    if (isIOS) {
      return CupertinoTextFormFieldRow(
        controller: controller,
        placeholder: placeholder ?? label,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        padding: padding ?? const EdgeInsets.all(12),
        enabled: enabled,
        decoration: BoxDecoration(
          color: CupertinoColors.tertiarySystemBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        style: theme.inputStyles.label,
      );
    } else {
      return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          labelStyle: theme.inputStyles.label,
          hintStyle: theme.inputStyles.hint,
          border: theme.inputStyles.border,
          focusedBorder: theme.inputStyles.focusedBorder,
          contentPadding: padding ?? const EdgeInsets.all(12),
        ),
      );
    }
  }
}
