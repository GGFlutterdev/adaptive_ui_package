import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../theme/adaptive_theme_provider.dart';

/// TextField adattivo (TextField / CupertinoTextField)
class AdaptiveTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final EdgeInsets? padding;

  const AdaptiveTextField({
    Key? key,
    this.controller,
    this.placeholder,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.maxLines = 1,
    this.padding,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: placeholder ?? label,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: maxLines,
        padding: padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CupertinoColors.tertiarySystemBackground,
          borderRadius: BorderRadius.circular(8),
        ),
      );
    } else {
      final theme = AdaptiveThemeProvider.of(context);
      return TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: maxLines,
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
