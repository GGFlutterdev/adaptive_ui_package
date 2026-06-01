import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:platform_adaptive_ui/platform_adaptive_ui.dart';

/// Scaffold adattivo che sceglie tra Scaffold e CupertinoPageScaffold
class AdaptiveScaffold extends StatelessWidget {
  final AdaptiveAppBar? appBar;
  final Widget body;
  final AdaptiveBottomNavBar? bottomNavigationBar;
  final Widget? floatingActionButton;

  const AdaptiveScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  /// Altezza standard di [CupertinoTabBar] (non esportata da Flutter).
  static const double _kCupertinoTabBarHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: appBar?.buildCupertinoNavigationBar(context),
        child: _buildCupertinoChild(context),
      );
    } else {
      return Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      );
    }
  }

  /// Compone body, bottom navigation bar e FAB dentro l'unico [child]
  /// accettato da [CupertinoPageScaffold].
  Widget _buildCupertinoChild(BuildContext context) {
    // Senza bottom bar nè FAB il body può essere usato direttamente.
    if (bottomNavigationBar == null && floatingActionButton == null) {
      return body;
    }

    final double bottomInset = MediaQuery.of(context).padding.bottom;

    final Widget content = bottomNavigationBar == null
        ? body
        : Column(
            children: [
              Expanded(child: body),
              bottomNavigationBar!,
            ],
          );

    if (floatingActionButton == null) {
      return content;
    }

    // Posiziona il FAB sopra la bottom bar (se presente) e la safe area.
    final double fabBottom = (bottomNavigationBar != null
            ? _kCupertinoTabBarHeight + bottomInset
            : bottomInset) +
        16.0;

    return Stack(
      children: [
        Positioned.fill(child: content),
        Positioned(
          right: 16.0,
          bottom: fabBottom,
          child: floatingActionButton!,
        ),
      ],
    );
  }
}
