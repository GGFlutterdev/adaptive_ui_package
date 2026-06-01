import 'package:flutter/material.dart';
import '../config/theme_config.dart';

/// Provider del tema adattivo.
///
/// Propaga ai widget discendenti il set di token [AdaptiveThemeData]
/// attualmente attivo (light o dark, in base alla luminosità risolta da
/// [AdaptiveApp]). I widget leggono da qui colori, stili input, spacing, ecc.
class AdaptiveThemeProvider extends InheritedWidget {
  /// Set completo di token attualmente attivo.
  final AdaptiveThemeData data;

  AdaptiveThemeProvider({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// Costruttore di compatibilità basato sui singoli token.
  ///
  /// Permette di costruire il provider passando i token separati invece di un
  /// [AdaptiveThemeData] già composto.
  AdaptiveThemeProvider.fromParts({
    Key? key,
    required ThemeColors colors,
    required TextThemeConfig textTheme,
    ButtonStyles? buttonStyles,
    required CupertinoButtonStyles cupertinoButtonStyles,
    required InputStyles inputStyles,
    required Spacing spacing,
    Brightness brightness = Brightness.light,
    required Widget child,
  }) : data = AdaptiveThemeData(
          colors: colors,
          textTheme: textTheme,
          buttonStyles: buttonStyles,
          cupertinoButtonStyles: cupertinoButtonStyles,
          inputStyles: inputStyles,
          spacing: spacing,
          brightness: brightness,
        ),
        super(key: key, child: child);

  /// Palette attiva.
  ThemeColors get colors => data.colors;

  /// Configurazione testuale attiva.
  TextThemeConfig get textTheme => data.textTheme;

  /// Stili dei bottoni Material attivi.
  ButtonStyles? get buttonStyles => data.buttonStyles;

  /// Stili dei bottoni Cupertino attivi.
  CupertinoButtonStyles get cupertinoButtonStyles => data.cupertinoButtonStyles;

  /// Stili degli input attivi.
  InputStyles get inputStyles => data.inputStyles;

  /// Spaziature attive.
  Spacing get spacing => data.spacing;

  /// Luminosità attiva.
  Brightness get brightness => data.brightness;

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

  /// Tema completo attivo, con fallback al tema chiaro di default.
  static AdaptiveThemeData dataOf(BuildContext context) =>
      maybeOf(context)?.data ?? AdaptiveThemeData.light;

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
    return data != oldWidget.data;
  }
}
