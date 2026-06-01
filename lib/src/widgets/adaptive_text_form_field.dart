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

  /// Stile del testo digitato.
  ///
  /// Se null, viene usato il `bodyMedium` del tema corrente.
  final TextStyle? style;

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
    this.style,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final inputStyles = AdaptiveThemeProvider.inputStylesOf(context);
    final colors = AdaptiveThemeProvider.colorsOf(context);
    final textStyle = style ?? Theme.of(context).textTheme.bodyMedium;

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
        decoration:
            inputStyles.toCupertinoDecoration(defaultFillColor: colors.surface),
        placeholderStyle: inputStyles.hint,
        style: textStyle,
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
