import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../theme/adaptive_theme_provider.dart';

/// Bottone adattivo principale (ElevatedButton su Material / CupertinoButton su iOS)
class AdaptiveButton extends StatelessWidget {
  /// Contenuto del bottone (tipicamente Text o Icon)
  final Widget child;

  /// Callback eseguita al tap
  final VoidCallback? onPressed;

  /// Colore di sfondo (può essere null per usare il tema)
  final Color? color;

  /// Padding interno del bottone (può essere null per usare il tema)
  final EdgeInsets? padding;

  /// Stile del testo sovrascrivibile
  final TextStyle? textStyle;

  const AdaptiveButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
    this.padding,
    this.textStyle,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveThemeProvider.of(context);
    final defaultStyle = textStyle ?? Theme.of(context).textTheme.bodyMedium!;

    if (isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        color: color ?? theme.cupertinoButtonStyles.primaryColor,
        padding: padding ?? theme.cupertinoButtonStyles.padding,
        child: DefaultTextStyle(
          style: defaultStyle.copyWith(color: Colors.white),
          child: child,
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: padding,
          textStyle: defaultStyle,
        ),
        child: child,
      );
    }
  }
}

/// Bottone di testo adattivo (TextButton su Material / CupertinoButton senza background su iOS)
class AdaptiveTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final TextStyle? textStyle;

  const AdaptiveTextButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
    this.textStyle,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = textStyle ??
        Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: color ?? (isIOS ? CupertinoColors.activeBlue : null),
            );

    if (isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: DefaultTextStyle(
          style: defaultStyle,
          child: child,
        ),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        style: color != null
            ? TextButton.styleFrom(foregroundColor: color, textStyle: textStyle)
            : TextButton.styleFrom(textStyle: textStyle),
        child: child,
      );
    }
  }
}

/// Bottone con icona adattivo (IconButton su Material / CupertinoButton su iOS)
class AdaptiveIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;

  const AdaptiveIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: IconTheme(
          data: IconThemeData(
            color: color ?? CupertinoColors.activeBlue,
            size: size,
          ),
          child: icon,
        ),
      );
    } else {
      return IconButton(
        onPressed: onPressed,
        icon: icon,
        color: color,
        iconSize: size ?? 24,
      );
    }
  }
}
