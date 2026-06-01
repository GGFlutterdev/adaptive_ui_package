import 'package:flutter/material.dart';
import '../config/theme_config.dart';

/// Provider del tema adattivo
class AdaptiveThemeProvider extends InheritedWidget {
  final ThemeColors colors;
  final TextThemeConfig textTheme;
  final ButtonStyles? buttonStyles;
  final CupertinoButtonStyles cupertinoButtonStyles;
  final InputStyles inputStyles;
  final Spacing spacing;

  const AdaptiveThemeProvider({
    Key? key,
    required this.colors,
    required this.textTheme,
    this.buttonStyles,
    required this.cupertinoButtonStyles,
    required this.inputStyles,
    required this.spacing,
    required Widget child,
  }) : super(key: key, child: child);

  static AdaptiveThemeProvider of(BuildContext context) {
    final AdaptiveThemeProvider? result =
        context.dependOnInheritedWidgetOfExactType<AdaptiveThemeProvider>();
    assert(result != null, 'No AdaptiveThemeProvider found in context');
    return result!;
  }

  /// Variante non-throwing: restituisce null se nessun provider è presente.
  ///
  /// Permette ai widget di funzionare anche senza [AdaptiveApp], ricadendo
  /// sui valori di default tramite gli accessor sottostanti.
  static AdaptiveThemeProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveThemeProvider>();
  }

  /// Colori del tema, con fallback ai default se non c'è provider.
  static ThemeColors colorsOf(BuildContext context) =>
      maybeOf(context)?.colors ?? ThemeColors.defaultColors;

  /// Stili degli input, con fallback ai default se non c'è provider.
  static InputStyles inputStylesOf(BuildContext context) =>
      maybeOf(context)?.inputStyles ?? InputStyles.defaultStyles;

  /// Stili dei bottoni Cupertino, con fallback ai default se non c'è provider.
  static CupertinoButtonStyles cupertinoButtonStylesOf(BuildContext context) =>
      maybeOf(context)?.cupertinoButtonStyles ??
      CupertinoButtonStyles.defaultStyles;

  /// Configurazione testuale, con fallback ai default se non c'è provider.
  static TextThemeConfig textThemeOf(BuildContext context) =>
      maybeOf(context)?.textTheme ?? TextThemeConfig.defaultConfig;

  @override
  bool updateShouldNotify(AdaptiveThemeProvider oldWidget) {
    return colors != oldWidget.colors ||
        textTheme != oldWidget.textTheme ||
        buttonStyles != oldWidget.buttonStyles ||
        cupertinoButtonStyles != oldWidget.cupertinoButtonStyles ||
        inputStyles != oldWidget.inputStyles ||
        spacing != oldWidget.spacing;
  }
}
