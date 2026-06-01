import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../theme/adaptive_theme_provider.dart';

/// Progress Indicator adattivo (CircularProgressIndicator / CupertinoActivityIndicator)
class AdaptiveProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final double radius;

  const AdaptiveProgressIndicator({
    Key? key,
    this.value,
    this.color,
    this.radius = 10.0,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? AdaptiveThemeProvider.colorsOf(context).primary;

    if (isIOS) {
      return CupertinoActivityIndicator(
        radius: radius,
        color: accent,
      );
    } else {
      return CircularProgressIndicator(
        value: value,
        color: accent,
      );
    }
  }
}
