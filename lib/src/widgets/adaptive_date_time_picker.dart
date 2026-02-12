import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// Date Picker adattivo
class AdaptiveDatePicker {
  static bool get isIOS => Platform.isIOS;

  /// Mostra il date picker in modo adattivo
  ///
  /// [initialDate] : data iniziale selezionata
  /// [firstDate] : data minima selezionabile
  /// [lastDate] : data massima selezionabile
  /// [cancelText] : testo pulsante Annulla (iOS)
  /// [confirmText] : testo pulsante Conferma (iOS)
  /// [textStyle] : stile testo pulsanti (iOS)
  static Future<DateTime?> showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String cancelText = 'Annulla',
    String confirmText = 'Conferma',
    TextStyle? textStyle,
  }) async {
    if (isIOS) {
      DateTime? selectedDate = initialDate;
      final defaultStyle = textStyle ?? Theme.of(context).textTheme.bodyMedium!;

      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                Container(
                  height: 44,
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text(cancelText, style: defaultStyle),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoButton(
                        child: Text(confirmText, style: defaultStyle),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: firstDate,
                    maximumDate: lastDate,
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDate = newDate;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      return selectedDate;
    } else {
      return showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );
    }
  }
}

/// Time Picker adattivo
class AdaptiveTimePicker {
  static bool get isIOS => Platform.isIOS;

  /// Mostra il time picker in modo adattivo
  ///
  /// [initialTime] : ora iniziale selezionata
  /// [cancelText] : testo pulsante Annulla (iOS)
  /// [confirmText] : testo pulsante Conferma (iOS)
  /// [textStyle] : stile testo pulsanti (iOS)
  static Future<TimeOfDay?> showTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    String cancelText = 'Annulla',
    String confirmText = 'Conferma',
    TextStyle? textStyle,
  }) async {
    if (isIOS) {
      TimeOfDay? selectedTime = initialTime;
      final now = DateTime.now();
      DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        initialTime.hour,
        initialTime.minute,
      );

      final TextStyle? defaultStyle =
          textStyle ?? Theme.of(context).textTheme.bodyMedium;

      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                Container(
                  height: 44,
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text(cancelText, style: defaultStyle),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoButton(
                        child: Text(confirmText, style: defaultStyle),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: selectedDateTime,
                    onDateTimeChanged: (DateTime newDateTime) {
                      selectedTime = TimeOfDay(
                        hour: newDateTime.hour,
                        minute: newDateTime.minute,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      return selectedTime;
    } else {
      return showTimePicker(
        context: context,
        initialTime: initialTime,
      );
    }
  }
}
