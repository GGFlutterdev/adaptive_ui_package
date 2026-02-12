import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// Slider adattivo (Slider / CupertinoSlider)
class AdaptiveSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final Color? activeColor;

  const AdaptiveSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.activeColor,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoSlider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        activeColor: activeColor ?? CupertinoColors.activeBlue,
      );
    } else {
      return Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        activeColor: activeColor,
      );
    }
  }
}
