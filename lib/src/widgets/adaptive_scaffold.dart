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

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: appBar as CupertinoNavigationBar?,
        child: body,
      );
    } else {
      return Scaffold(
        appBar: appBar as PreferredSizeWidget?,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      );
    }
  }
}
