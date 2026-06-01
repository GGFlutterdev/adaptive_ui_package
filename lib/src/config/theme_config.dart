import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Configurazione dei colori del tema
class ThemeColors {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color background;
  final Color surface;

  /// Colore di testo e icone mostrati sopra [surface].
  ///
  /// Usato come default per il contenuto di AppBar/NavigationBar quando non
  /// viene specificato un colore esplicito.
  final Color onSurface;
  final Color error;

  const ThemeColors({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
    this.onSurface = Colors.black,
    required this.error,
  });

  /// Palette di default (light)
  static const ThemeColors defaultColors = ThemeColors(
    primary: Color(0xFF6200EE),
    onPrimary: Colors.white,
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    background: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    error: Color(0xFFB00020),
  );

  /// Palette di default (dark)
  static const ThemeColors defaultDarkColors = ThemeColors(
    primary: Color(0xFFBB86FC),
    onPrimary: Colors.black,
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
    error: Color(0xFFCF6679),
  );

  /// Crea una copia di questi colori sovrascrivendo i campi indicati.
  ThemeColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? background,
    Color? surface,
    Color? onSurface,
    Color? error,
  }) {
    return ThemeColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      error: error ?? this.error,
    );
  }
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

  /// Colore di riempimento dei campi (usato su iOS/Cupertino).
  ///
  /// Se null, su iOS si usa [CupertinoColors.tertiarySystemBackground].
  final Color? fillColor;

  const InputStyles({
    required this.label,
    required this.hint,
    required this.border,
    required this.focusedBorder,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
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

  /// Stili di default per la dark mode
  static final InputStyles defaultDarkStyles = InputStyles(
    label: const TextStyle(fontSize: 14, color: Colors.white70),
    hint: const TextStyle(fontSize: 14, color: Colors.white54),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFBB86FC), width: 2),
    ),
    prefixIcon: null,
    suffixIcon: null,
  );

  /// Crea una copia di questi stili sovrascrivendo i campi indicati.
  InputStyles copyWith({
    TextStyle? label,
    TextStyle? hint,
    OutlineInputBorder? border,
    OutlineInputBorder? focusedBorder,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
  }) {
    return InputStyles(
      label: label ?? this.label,
      hint: hint ?? this.hint,
      border: border ?? this.border,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      fillColor: fillColor ?? this.fillColor,
    );
  }

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

  /// Deriva una [BoxDecoration] coerente con questi stili, per i campi
  /// Cupertino (iOS) che non accettano un [InputDecoration].
  ///
  /// Usa il raggio e il colore del bordo configurati; passa [focused] true
  /// per applicare l'aspetto del [focusedBorder].
  ///
  /// Se [fillColor] non è specificato, viene usato [defaultFillColor] (di
  /// norma il `surface` del tema corrente) e, in ultima istanza,
  /// [CupertinoColors.tertiarySystemBackground].
  BoxDecoration toCupertinoDecoration({
    bool focused = false,
    Color? defaultFillColor,
  }) {
    final OutlineInputBorder activeBorder = focused ? focusedBorder : border;
    return BoxDecoration(
      color: fillColor ??
          defaultFillColor ??
          CupertinoColors.tertiarySystemBackground,
      borderRadius: activeBorder.borderRadius,
      border: Border.all(
        color: activeBorder.borderSide.color,
        width: activeBorder.borderSide.width,
      ),
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

/// Insieme completo di token di stile per una singola modalità (light o dark).
///
/// Raggruppa palette, font e stili dei componenti in un unico oggetto, così
/// da poter passare a [AdaptiveApp] una configurazione separata per la light
/// mode e una per la dark mode.
class AdaptiveThemeData {
  /// Palette dei colori.
  final ThemeColors colors;

  /// Configurazione testuale (font, dimensioni, pesi).
  final TextThemeConfig textTheme;

  /// Stili dei bottoni Material (opzionali).
  final ButtonStyles? buttonStyles;

  /// Stili dei bottoni Cupertino.
  final CupertinoButtonStyles cupertinoButtonStyles;

  /// Stili dei campi di input.
  final InputStyles inputStyles;

  /// Spaziature.
  final Spacing spacing;

  /// Luminosità a cui appartiene questo set di token.
  final Brightness brightness;

  const AdaptiveThemeData({
    required this.colors,
    required this.textTheme,
    this.buttonStyles,
    required this.cupertinoButtonStyles,
    required this.inputStyles,
    required this.spacing,
    this.brightness = Brightness.light,
  });

  /// Tema chiaro di default del package.
  static final AdaptiveThemeData light = AdaptiveThemeData(
    colors: ThemeColors.defaultColors,
    textTheme: TextThemeConfig.defaultConfig,
    cupertinoButtonStyles: CupertinoButtonStyles.defaultStyles,
    inputStyles: InputStyles.defaultStyles,
    spacing: Spacing.defaultSpacing,
    brightness: Brightness.light,
  );

  /// Tema scuro di default del package.
  static final AdaptiveThemeData dark = AdaptiveThemeData(
    colors: ThemeColors.defaultDarkColors,
    textTheme: TextThemeConfig.defaultConfig,
    cupertinoButtonStyles: CupertinoButtonStyles.defaultStyles,
    inputStyles: InputStyles.defaultDarkStyles,
    spacing: Spacing.defaultSpacing,
    brightness: Brightness.dark,
  );

  /// Crea una copia di questo tema sovrascrivendo i campi indicati.
  AdaptiveThemeData copyWith({
    ThemeColors? colors,
    TextThemeConfig? textTheme,
    ButtonStyles? buttonStyles,
    CupertinoButtonStyles? cupertinoButtonStyles,
    InputStyles? inputStyles,
    Spacing? spacing,
    Brightness? brightness,
  }) {
    return AdaptiveThemeData(
      colors: colors ?? this.colors,
      textTheme: textTheme ?? this.textTheme,
      buttonStyles: buttonStyles ?? this.buttonStyles,
      cupertinoButtonStyles:
          cupertinoButtonStyles ?? this.cupertinoButtonStyles,
      inputStyles: inputStyles ?? this.inputStyles,
      spacing: spacing ?? this.spacing,
      brightness: brightness ?? this.brightness,
    );
  }
}
