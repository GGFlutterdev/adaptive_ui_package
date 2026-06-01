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

  /// Stile del testo digitato.
  ///
  /// Se null, viene usato il `bodyMedium` del tema corrente.
  final TextStyle? style;

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
    this.style,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final inputStyles = AdaptiveThemeProvider.inputStylesOf(context);
    final colors = AdaptiveThemeProvider.colorsOf(context);
    final textStyle = style ?? Theme.of(context).textTheme.bodyMedium;

    if (isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: placeholder ?? label,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: maxLines,
        padding: padding ?? const EdgeInsets.all(12),
        style: textStyle,
        placeholderStyle: inputStyles.hint,
        prefix: inputStyles.prefixIcon,
        suffix: inputStyles.suffixIcon,
        decoration:
            inputStyles.toCupertinoDecoration(defaultFillColor: colors.surface),
      );
    } else {
      return TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: maxLines,
        style: textStyle,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          labelStyle: inputStyles.label,
          hintStyle: inputStyles.hint,
          filled: true,
          fillColor: inputStyles.fillColor ?? colors.surface,
          border: inputStyles.border,
          focusedBorder: inputStyles.focusedBorder,
          prefixIcon: inputStyles.prefixIcon,
          suffixIcon: inputStyles.suffixIcon,
          contentPadding: padding ?? const EdgeInsets.all(12),
        ),
      );
    }
  }
}
