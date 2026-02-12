import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../config/theme_config.dart';
import '../theme/adaptive_theme_provider.dart';

/// App adattiva che sceglie tra MaterialApp e CupertinoApp
class AdaptiveApp extends StatelessWidget {
  final String title;
  final Widget home;
  final ThemeColors colors;
  final TextThemeConfig textTheme;
  final ButtonStyles? buttonStyles;
  final CupertinoButtonStyles cupertinoButtonStyles;
  final InputStyles inputStyles;
  final Spacing spacing;
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
    this.routes,
    this.debugShowCheckedModeBanner = true,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    return AdaptiveThemeProvider(
      colors: colors,
      textTheme: textTheme,
      buttonStyles: buttonStyles,
      cupertinoButtonStyles: cupertinoButtonStyles,
      inputStyles: inputStyles,
      spacing: spacing,
      child: isIOS ? _buildCupertinoApp() : _buildMaterialApp(),
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      theme: ThemeData(
        primaryColor: colors.primary,
        scaffoldBackgroundColor: colors.background,
        colorScheme: ColorScheme(
          primary: colors.primary,
          secondary: colors.secondary,
          surface: colors.surface,
          error: colors.error,
          onPrimary: colors.onPrimary,
          onSecondary: colors.onSecondary,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: textTheme.headline,
          bodyLarge: textTheme.body,
          bodySmall: textTheme.caption,
          labelLarge: textTheme.button,
        ),
        fontFamily: textTheme.fontFamily,
      ),
      home: home,
      routes: routes ?? {},
    );
  }

  Widget _buildCupertinoApp() {
    return CupertinoApp(
      title: title,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      theme: CupertinoThemeData(
        primaryColor: colors.primary,
        scaffoldBackgroundColor: colors.background,
        textTheme: CupertinoTextThemeData(
          textStyle: textTheme.body,
          primaryColor: colors.primary,
        ),
      ),
      home: home,
      routes: routes ?? {},
    );
  }
}
