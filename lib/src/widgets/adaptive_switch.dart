import 'package:flutter/material.dart';
import '../theme/adaptive_theme_provider.dart';

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
    final accent =
        activeColor ?? AdaptiveThemeProvider.colorsOf(context).primary;
    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeThumbColor: accent,
      activeTrackColor: accent,
    );
  }
}
