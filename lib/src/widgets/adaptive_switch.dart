import 'package:flutter/material.dart';

/// Switch adattivo - usa sempre Switch.adaptive per adattarsi alla piattaforma
class AdaptiveSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  const AdaptiveSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeThumbColor: activeColor,
      activeTrackColor: activeColor,
    );
  }
}
