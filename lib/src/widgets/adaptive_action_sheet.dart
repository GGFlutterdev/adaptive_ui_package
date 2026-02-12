import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// Rappresenta un singolo item di un [AdaptiveActionSheet].
/// Può avere un'etichetta, un'icona opzionale e uno stato distruttivo.
class AdaptiveActionSheetItem {
  /// Testo visualizzato per l'azione
  final String label;

  /// Callback eseguita quando l'azione viene premuta
  final VoidCallback onPressed;

  /// Indica se l'azione è distruttiva (es. elimina dati)
  final bool isDestructive;

  /// Icona opzionale mostrata a sinistra dell'azione
  final Widget? icon;

  const AdaptiveActionSheetItem({
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
    this.icon,
  });
}

/// Classe helper per mostrare un Action Sheet in modo adattivo
/// su iOS (CupertinoActionSheet) o Android (ModalBottomSheet + ListTile)
class AdaptiveActionSheet {
  /// Ritorna true se la piattaforma corrente è iOS
  static bool get isIOS => Platform.isIOS;

  /// Mostra l'action sheet in modo adattivo
  ///
  /// - [context]: BuildContext necessario per mostrare il popup
  /// - [title]: titolo opzionale dell'action sheet
  /// - [message]: messaggio opzionale sotto il titolo
  /// - [actions]: lista di [AdaptiveActionSheetItem] con le azioni disponibili
  /// - [cancelLabel]: testo del pulsante di annulla (iOS e Android)
  ///
  /// Su iOS viene mostrato un [CupertinoActionSheet].
  /// Su Android viene mostrato un [showModalBottomSheet] con [ListTile].
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? message,
    required List<AdaptiveActionSheetItem> actions,
    String? cancelLabel,
  }) {
    if (isIOS) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: title != null ? Text(title) : null,
            message: message != null ? Text(message) : null,
            actions: actions
                .map((action) => CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        action.onPressed();
                      },
                      isDestructiveAction: action.isDestructive,
                      child: Text(action.label),
                    ))
                .toList(),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: Text(cancelLabel ?? 'Annulla'),
            ),
          );
        },
      );
    } else {
      return showModalBottomSheet<T>(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(message),
                  ),
                const Divider(),
                ...actions.map((action) {
                  return ListTile(
                    leading: action.icon,
                    title: Text(
                      action.label,
                      style: TextStyle(
                        color: action.isDestructive ? Colors.red : null,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      action.onPressed();
                    },
                  );
                }),
                if (cancelLabel != null) ...[
                  const Divider(),
                  ListTile(
                    title: Text(
                      cancelLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ],
            ),
          );
        },
      );
    }
  }
}

/// Classe helper per mostrare un Modal Bottom Sheet adattivo
/// su iOS (CupertinoModalPopup) o Android (showModalBottomSheet)
class AdaptiveModalBottomSheet {
  /// Ritorna true se la piattaforma corrente è iOS
  static bool get isIOS => Platform.isIOS;

  /// Mostra il modal bottom sheet in modo adattivo
  ///
  /// - [context]: BuildContext necessario per mostrare il popup
  /// - [child]: contenuto del modal
  /// - [isDismissible]: se true, il modal può essere chiuso tappando fuori
  /// - [enableDrag]: se true, l'utente può trascinare il modal verso il basso per chiuderlo
  ///
  /// Su iOS viene mostrato un [CupertinoModalPopup] con angoli arrotondati e SafeArea.
  /// Su Android viene mostrato un [showModalBottomSheet] standard.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    if (isIOS) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: SafeArea(
              child: child,
            ),
          );
        },
      );
    } else {
      return showModalBottomSheet<T>(
        context: context,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        builder: (BuildContext context) => child,
      );
    }
  }
}
