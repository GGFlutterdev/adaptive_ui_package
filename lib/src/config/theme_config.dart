import 'package:flutter/material.dart';

/// Configurazione dei colori del tema
class ThemeColors {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color background;
  final Color surface;
  final Color error;

  const ThemeColors({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
    required this.error,
  });

  /// Tema di default
  static const ThemeColors defaultColors = ThemeColors(
    primary: Color(0xFF6200EE),
    onPrimary: Colors.white,
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    background: Colors.white,
    surface: Colors.white,
    error: Color(0xFFB00020),
  );
}

/// Configurazione del tema testuale
class TextThemeConfig {
  final String fontFamily;
  final TextStyle headline;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle button;

  const TextThemeConfig({
    required this.fontFamily,
    required this.headline,
    required this.body,
    required this.caption,
    required this.button,
  });

  /// Tema testuale di default
  static const TextThemeConfig defaultConfig = TextThemeConfig(
    fontFamily: 'Roboto',
    headline: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    body: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    caption: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );
}

/// Stili per i bottoni Material
class ButtonStyles {
  final ButtonStyle primary;
  final ButtonStyle secondary;
  final ButtonStyle text;
  final ButtonStyle disabled;

  const ButtonStyles({
    required this.primary,
    required this.secondary,
    required this.text,
    required this.disabled,
  });
}

/// Stili per i bottoni Cupertino
class CupertinoButtonStyles {
  final Color primaryColor;
  final Color secondaryColor;
  final EdgeInsets padding;
  final TextStyle textStyle;

  const CupertinoButtonStyles({
    required this.primaryColor,
    required this.secondaryColor,
    required this.padding,
    required this.textStyle,
  });

  /// Stili di default
  static const CupertinoButtonStyles defaultStyles = CupertinoButtonStyles(
    primaryColor: Color(0xFF007AFF),
    secondaryColor: Color(0xFF5AC8FA),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
  );
}

/// Stili per gli input field
class InputStyles {
  final TextStyle label;
  final TextStyle hint;
  final OutlineInputBorder border;
  final OutlineInputBorder focusedBorder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const InputStyles({
    required this.label,
    required this.hint,
    required this.border,
    required this.focusedBorder,
    this.prefixIcon,
    this.suffixIcon,
  });

  /// Stili di default
  static final InputStyles defaultStyles = InputStyles(
    label: const TextStyle(fontSize: 14, color: Colors.grey),
    hint: const TextStyle(fontSize: 14, color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF6200EE), width: 2),
    ),
    prefixIcon: null,
    suffixIcon: null,
  );

  /// Metodo helper per creare InputDecoration
  InputDecoration decoration({String? hintText, String? labelText}) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: hint,
      labelStyle: label,
      border: border,
      focusedBorder: focusedBorder,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}

/// Configurazione degli spacing
class Spacing {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const Spacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  /// Spacing di default
  static const Spacing defaultSpacing = Spacing(
    xs: 4.0,
    sm: 8.0,
    md: 16.0,
    lg: 24.0,
    xl: 32.0,
  );
}
