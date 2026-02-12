import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// AlertDialog adattivo che mostra un dialogo coerente con la piattaforma
/// - Su iOS utilizza [CupertinoAlertDialog]
/// - Su Android (e altre piattaforme) utilizza [AlertDialog]
class AdaptiveAlertDialog extends StatelessWidget {
  /// Titolo opzionale del dialog
  final Widget? title;

  /// Contenuto opzionale del dialog
  final Widget? content;

  /// Lista di azioni da mostrare (bottoni)
  final List<Widget> actions;

  const AdaptiveAlertDialog({
    Key? key,
    this.title,
    this.content,
    required this.actions,
  }) : super(key: key);

  /// Ritorna true se la piattaforma corrente è iOS
  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
    } else {
      return AlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
    }
  }

  /// Mostra l'[AdaptiveAlertDialog] in modo adattivo
  ///
  /// - [context]: BuildContext necessario per mostrare il dialog
  /// - [title]: widget opzionale per il titolo
  /// - [content]: widget opzionale per il contenuto
  /// - [actions]: lista di bottoni / azioni
  ///
  /// Ritorna un [Future] con il risultato del dialogo (può essere null)
  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? content,
    required List<Widget> actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AdaptiveAlertDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }
}

/// Rappresenta un'azione di dialogo adattiva
/// - Su iOS utilizza [CupertinoDialogAction]
/// - Su Android utilizza [TextButton] con supporto per azioni distruttive
class AdaptiveDialogAction extends StatelessWidget {
  /// Contenuto del bottone (testo, icona, ecc.)
  final Widget child;

  /// Callback eseguita al click
  final VoidCallback? onPressed;

  /// Indica se l'azione è distruttiva (es. elimina dati)
  final bool isDestructiveAction;

  /// Indica se è l'azione di default (es. conferma primaria)
  final bool isDefaultAction;

  const AdaptiveDialogAction({
    Key? key,
    required this.child,
    required this.onPressed,
    this.isDestructiveAction = false,
    this.isDefaultAction = false,
  }) : super(key: key);

  /// Ritorna true se la piattaforma corrente è iOS
  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoDialogAction(
        onPressed: onPressed,
        isDestructiveAction: isDestructiveAction,
        isDefaultAction: isDefaultAction,
        child: child,
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        style: isDestructiveAction
            ? TextButton.styleFrom(foregroundColor: Colors.red)
            : null,
        child: child,
      );
    }
  }
}
