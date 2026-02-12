import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// AppBar adattiva che sceglie automaticamente tra:
/// - [AppBar] su Android e altre piattaforme Material
/// - [CupertinoNavigationBar] su iOS
///
/// Permette di specificare titolo, azioni, leading, colore di sfondo e comportamento
/// della freccia di ritorno automatica.
class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Titolo dell'AppBar / NavigationBar
  final Widget title;

  /// Lista di widget mostrati come azioni sulla destra
  final List<Widget>? actions;

  /// Widget mostrato sulla sinistra (tipicamente back button o menu)
  final Widget? leading;

  /// Colore di sfondo dell'AppBar / NavigationBar
  final Color? backgroundColor;

  /// Se true, mostra automaticamente il pulsante di back quando necessario
  final bool automaticallyImplyLeading;

  const AdaptiveAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  /// Ritorna true se la piattaforma corrente è iOS
  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoNavigationBar(
        middle: title,
        trailing: actions != null && actions!.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              )
            : null,
        leading: leading,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
      );
    } else {
      return AppBar(
        title: title,
        actions: actions,
        leading: leading,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
      );
    }
  }

  /// Restituisce l'altezza preferita dell'AppBar
  /// Compatibile con [PreferredSizeWidget]
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
