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
  /// - [backgroundColor]: colore di sfondo del foglio. Se `null`, non viene
  ///   disegnato alcuno sfondo opaco sopra il [child] (così il child è libero
  ///   di definire il proprio sfondo, anche scuro/custom). Se valorizzato, il
  ///   colore viene risolto rispetto alla brightness reale del contesto su iOS.
  /// - [borderRadius]: raggio degli angoli del foglio. Default
  ///   `BorderRadius.vertical(top: Radius.circular(12))`. Su Android viene
  ///   applicato tramite lo `shape` del bottom sheet. Passare un valore proprio
  ///   evita il doppio arrotondamento quando il [child] arrotonda già da sé.
  /// - [useSafeArea]: se true (default) il contenuto iOS viene avvolto in una
  ///   [SafeArea]. Vedi sotto per il comportamento degli inset.
  ///
  /// Su iOS viene mostrato un [CupertinoModalPopup] con angoli arrotondati.
  /// Quando [useSafeArea] è true il contenuto è avvolto in una [SafeArea] con
  /// `top: false`: trattandosi di un foglio ancorato in basso, l'inset
  /// superiore (status bar) **non** viene applicato — evitando il gap/striscia
  /// in cima — mentre l'inset inferiore (home indicator) viene mantenuto.
  ///
  /// Su Android viene mostrato un [showModalBottomSheet] standard; se forniti,
  /// [backgroundColor] e [borderRadius] vengono propagati senza sovrascrivere
  /// lo sfondo del [child].
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    bool useSafeArea = true,
  }) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? const BorderRadius.vertical(top: Radius.circular(12));

    if (isIOS) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) {
          // Non applichiamo l'inset superiore: il foglio è ancorato in basso,
          // quindi il top inset (status bar) creerebbe un gap indesiderato.
          final Widget content = useSafeArea
              ? SafeArea(
                  top: false,
                  child: child,
                )
              : child;

          // Se non viene richiesto uno sfondo esplicito lasciamo che sia il
          // child a definire il proprio (evita la striscia bianca su child
          // con sfondo custom). Il borderRadius viene comunque applicato via
          // clip così gli angoli restano arrotondati.
          if (backgroundColor == null) {
            return ClipRRect(
              borderRadius: effectiveBorderRadius,
              child: content,
            );
          }

          return Container(
            decoration: BoxDecoration(
              // Risolviamo il colore rispetto alla brightness reale del
              // contesto (così systemBackground non resta bianco in dark mode).
              color: backgroundColor is CupertinoDynamicColor
                  ? backgroundColor.resolveFrom(context)
                  : backgroundColor,
              borderRadius: effectiveBorderRadius,
            ),
            clipBehavior: Clip.antiAlias,
            child: content,
          );
        },
      );
    } else {
      return showModalBottomSheet<T>(
        context: context,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        backgroundColor: backgroundColor,
        shape: borderRadius != null
            ? RoundedRectangleBorder(borderRadius: effectiveBorderRadius)
            : null,
        builder: (BuildContext context) => child,
      );
    }
  }
}
