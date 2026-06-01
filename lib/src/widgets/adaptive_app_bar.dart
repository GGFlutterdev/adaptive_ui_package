import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../theme/adaptive_theme_provider.dart';

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

  /// Colore di sfondo dell'AppBar / NavigationBar.
  ///
  /// Se null, viene usato il colore `surface` del tema corrente.
  final Color? backgroundColor;

  /// Colore di testo e icone dell'AppBar / NavigationBar.
  ///
  /// Se null, viene usato il colore `onSurface` del tema corrente.
  final Color? foregroundColor;

  /// Se true, mostra automaticamente il pulsante di back quando necessario
  final bool automaticallyImplyLeading;

  const AdaptiveAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  /// Ritorna true se la piattaforma corrente è iOS
  static bool get isIOS => Platform.isIOS;

  /// Colore di sfondo effettivo: quello esplicito o, in mancanza, il
  /// `surface` del tema corrente.
  Color _effectiveBackgroundColor(BuildContext context) =>
      backgroundColor ?? AdaptiveThemeProvider.colorsOf(context).surface;

  /// Colore di testo/icone effettivo: quello esplicito o, in mancanza, il
  /// `onSurface` del tema corrente.
  Color _effectiveForegroundColor(BuildContext context) =>
      foregroundColor ?? AdaptiveThemeProvider.colorsOf(context).onSurface;

  /// Applica [color] come colore di default per testo e icone di [child].
  ///
  /// Necessario su iOS, dove [CupertinoNavigationBar] non espone una
  /// proprietà per colorare direttamente i propri contenuti.
  Widget _tint(Widget child, Color color) {
    return IconTheme.merge(
      data: IconThemeData(color: color),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: color),
        child: child,
      ),
    );
  }

  /// Costruisce la [CupertinoNavigationBar] equivalente a questa AppBar.
  ///
  /// Utile per [CupertinoPageScaffold.navigationBar], che richiede un
  /// [ObstructingPreferredSizeWidget] e non accetta direttamente questo wrapper.
  CupertinoNavigationBar buildCupertinoNavigationBar(BuildContext context) {
    final Color foreground = _effectiveForegroundColor(context);
    return CupertinoNavigationBar(
      middle: _tint(title, foreground),
      trailing: actions != null && actions!.isNotEmpty
          ? _tint(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),
              foreground,
            )
          : null,
      leading: leading != null ? _tint(leading!, foreground) : null,
      backgroundColor: _effectiveBackgroundColor(context),
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  /// Costruisce la [AppBar] Material equivalente a questa AppBar.
  AppBar buildMaterialAppBar(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      leading: leading,
      backgroundColor: _effectiveBackgroundColor(context),
      foregroundColor: _effectiveForegroundColor(context),
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return buildCupertinoNavigationBar(context);
    } else {
      return buildMaterialAppBar(context);
    }
  }

  /// Restituisce l'altezza preferita dell'AppBar
  /// Compatibile con [PreferredSizeWidget]
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
