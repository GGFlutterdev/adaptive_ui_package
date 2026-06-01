import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../config/theme_config.dart';
import '../theme/adaptive_theme_provider.dart';

/// App adattiva che sceglie tra MaterialApp e CupertinoApp.
///
/// Supporta sia la light mode che la dark mode: passa un [darkTheme] e scegli
/// con [themeMode] quale modalità usare (di default segue il sistema). I token
/// (palette, font, stili) della modalità attiva vengono propagati a tutti gli
/// `Adaptive*` widget tramite [AdaptiveThemeProvider].
class AdaptiveApp extends StatelessWidget {
  final String title;
  final Widget home;

  // --- Token della light mode (compatibilità con l'API precedente) ---
  final ThemeColors colors;
  final TextThemeConfig textTheme;
  final ButtonStyles? buttonStyles;
  final CupertinoButtonStyles cupertinoButtonStyles;
  final InputStyles inputStyles;
  final Spacing spacing;

  /// Tema chiaro completo. Se fornito, ha la precedenza sui singoli token
  /// ([colors], [textTheme], ...).
  final AdaptiveThemeData? theme;

  /// Tema scuro completo. Se null, in dark mode si ricade sul tema chiaro.
  final AdaptiveThemeData? darkTheme;

  /// Modalità del tema: chiaro, scuro o in base al sistema (default).
  final ThemeMode themeMode;

  /// Delegate di localizzazione forniti dal consumer.
  ///
  /// Vengono inoltrati a entrambi i rami; nel ramo Cupertino i delegate
  /// Material/Cupertino/Widgets di default vengono comunque accodati, così i
  /// widget Material (dialog, bottom sheet, selection controls) funzionano
  /// anche su iOS.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Locale supportati dall'app.
  final Iterable<Locale> supportedLocales;

  /// Locale forzato; se null segue il sistema.
  final Locale? locale;

  final Map<String, WidgetBuilder>? routes;
  final bool debugShowCheckedModeBanner;

  const AdaptiveApp({
    Key? key,
    required this.title,
    required this.home,
    this.colors = ThemeColors.defaultColors,
    this.textTheme = TextThemeConfig.defaultConfig,
    this.buttonStyles,
    this.cupertinoButtonStyles = CupertinoButtonStyles.defaultStyles,
    this.inputStyles = const InputStyles(
      label: TextStyle(fontSize: 14, color: Colors.grey),
      hint: TextStyle(fontSize: 14, color: Colors.grey),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
    ),
    this.spacing = Spacing.defaultSpacing,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.locale,
    this.routes,
    this.debugShowCheckedModeBanner = true,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;

  /// Token della light mode: il [theme] esplicito o, in mancanza, quelli
  /// composti dai singoli parametri.
  AdaptiveThemeData get _lightData =>
      theme ??
      AdaptiveThemeData(
        colors: colors,
        textTheme: textTheme,
        buttonStyles: buttonStyles,
        cupertinoButtonStyles: cupertinoButtonStyles,
        inputStyles: inputStyles,
        spacing: spacing,
        brightness: Brightness.light,
      );

  /// Token della dark mode: il [darkTheme] esplicito o, in mancanza, quelli
  /// della light mode (così le app esistenti non cambiano aspetto).
  AdaptiveThemeData get _darkData => darkTheme ?? _lightData;

  /// Risolve la luminosità effettiva combinando [themeMode] e il sistema.
  Brightness _resolveBrightness(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return MediaQuery.platformBrightnessOf(context);
    }
  }

  /// Token attivi in base alla luminosità risolta.
  AdaptiveThemeData _activeData(BuildContext context) =>
      _resolveBrightness(context) == Brightness.dark ? _darkData : _lightData;

  @override
  Widget build(BuildContext context) {
    return isIOS ? _buildCupertinoApp() : _buildMaterialApp();
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      theme: _buildMaterialTheme(_lightData),
      darkTheme: _buildMaterialTheme(_darkData),
      themeMode: themeMode,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
      builder: (context, child) {
        return AdaptiveThemeProvider(
          data: _activeData(context),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: home,
      routes: routes ?? {},
    );
  }

  Widget _buildCupertinoApp() {
    return CupertinoApp(
      title: title,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      // brightness null in modalità "system" così Cupertino segue il sistema.
      theme: CupertinoThemeData(
        brightness: themeMode == ThemeMode.system
            ? null
            : (themeMode == ThemeMode.dark
                ? Brightness.dark
                : Brightness.light),
        primaryColor: _lightData.colors.primary,
      ),
      // Accoda i delegate di default: senza questi i widget Material aperti
      // come route (dialog, bottom sheet, selection controls dei TextField)
      // vanno in crash con "No MaterialLocalizations found" su iOS.
      // I duplicati di tipo non danno problemi: vince il primo delegate.
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        ...?localizationsDelegates,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      locale: locale,
      builder: (context, child) {
        final active = _activeData(context);
        return AdaptiveThemeProvider(
          data: active,
          child: CupertinoTheme(
            data: _buildCupertinoTheme(active),
            // CupertinoApp non fornisce uno ScaffoldMessenger: senza, gli
            // SnackBar Material falliscono su iOS. Lo aggiungiamo qui, sopra
            // il Navigator radice, una volta per tutte le route.
            child: ScaffoldMessenger(
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
      home: home,
      routes: routes ?? {},
    );
  }

  /// Costruisce il [ThemeData] Material per un set di token.
  ThemeData _buildMaterialTheme(AdaptiveThemeData data) {
    final c = data.colors;
    return ThemeData(
      brightness: data.brightness,
      primaryColor: c.primary,
      scaffoldBackgroundColor: c.background,
      colorScheme: ColorScheme(
        brightness: data.brightness,
        primary: c.primary,
        secondary: c.secondary,
        surface: c.surface,
        error: c.error,
        onPrimary: c.onPrimary,
        onSecondary: c.onSecondary,
        onSurface: c.onSurface,
        onError:
            data.brightness == Brightness.dark ? Colors.black : Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: data.textTheme.headline,
        bodyLarge: data.textTheme.body,
        bodyMedium: data.textTheme.body,
        bodySmall: data.textTheme.caption,
        labelLarge: data.textTheme.button,
      ),
      fontFamily: data.textTheme.fontFamily,
    );
  }

  /// Costruisce il [CupertinoThemeData] per un set di token.
  CupertinoThemeData _buildCupertinoTheme(AdaptiveThemeData data) {
    final c = data.colors;
    return CupertinoThemeData(
      brightness: data.brightness,
      primaryColor: c.primary,
      scaffoldBackgroundColor: c.background,
      barBackgroundColor: c.surface,
      textTheme: CupertinoTextThemeData(
        primaryColor: c.primary,
        textStyle: data.textTheme.body.copyWith(color: c.onSurface),
      ),
    );
  }
}
