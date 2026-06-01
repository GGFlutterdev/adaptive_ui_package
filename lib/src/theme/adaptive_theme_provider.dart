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
