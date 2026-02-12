import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

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
    if (isIOS) {
      return CupertinoActivityIndicator(
        radius: radius,
        color: color,
      );
    } else {
      return CircularProgressIndicator(
        value: value,
        color: color,
      );
    }
  }
}
